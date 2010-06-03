package air.update.core
{
    import air.update.states.*;
    import air.update.utils.*;
    import flash.events.*;
    import flash.filesystem.*;
    import flash.net.*;
    import flash.utils.*;

    public class UCFUnpackager extends HSM
    {
        private var m_validator:Object;
        private var m_ucfParseState:uint = 0;
        private var _data:ByteArray;
        private var _path:String;
        private var _fileCommentLength:uint;
        private var m_isComplete:Boolean = false;
        private var source:URLStream;
        private var m_fileCount:uint = 0;
        private var _currentLFH:ByteArray;
        private var _extraFieldLength:uint;
        private var identifier:String;
        private var _fileRelativeOffset:uint;
        private var m_dir:File;
        private var _root:Object;
        private var _compressedSize:uint;
        private var _generalPurposeBitFlags:uint;
        private var _uncompressedSize:uint;
        private var isDirectory:Boolean;
        private var _compressionMethod:uint;
        private var _filenameLength:uint;
        private var m_enableSignatureValidation:Boolean = false;
        static const AT_COMPLETE:uint = 12;
        static const AT_CDEXTRA_FIELD:uint = 10;
        static const AT_CDHEADERMAGIC:uint = 8;
        static const AT_HEADER:uint = 1;
        static const AT_FILENAME:uint = 2;
        static const AT_ERROR:uint = 6;
        static const AT_ABORTED:uint = 13;
        static const AT_END:uint = 5;
        static const AT_DATA:uint = 4;
        static const AT_CDCOMMENT:uint = 11;
        static const AT_CDHEADER:uint = 7;
        static const AT_CDFILENAME:uint = 9;
        static const AT_START:uint = 0;
        static const AT_EXTRA_FIELD:uint = 3;

        public function UCFUnpackager()
        {
            _root = new Object();
            m_validator = new Object();
            super(initialized);
            return;
        }// end function

        protected function onDone() : void
        {
            return;
        }// end function

        public function get isComplete() : Boolean
        {
            return m_isComplete;
        }// end function

        private function unpackaging(event:Event) : void
        {
            switch(event.type)
            {
                case HSMEvent.ENTER:
                {
                    source = new URLStream();
                    source.endian = Endian.LITTLE_ENDIAN;
                    source.addEventListener(ProgressEvent.PROGRESS, dispatch);
                    source.addEventListener(HTTPStatusEvent.HTTP_STATUS, dispatch);
                    source.addEventListener(IOErrorEvent.IO_ERROR, dispatch);
                    source.addEventListener(SecurityErrorEvent.SECURITY_ERROR, dispatch);
                    source.addEventListener(Event.COMPLETE, dispatch);
                    source.load(new URLRequest(identifier));
                    break;
                }
                case ProgressEvent.PROGRESS:
                {
                    onData(event as ProgressEvent);
                    break;
                }
                case HTTPStatusEvent.HTTP_STATUS:
                {
                    dispatchEvent(event.clone());
                    break;
                }
                case IOErrorEvent.IO_ERROR:
                case SecurityErrorEvent.SECURITY_ERROR:
                {
                    m_ucfParseState = AT_ERROR;
                    dispatchEvent(event.clone());
                    break;
                }
                case Event.COMPLETE:
                {
                    onComplete(event);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function set enableSignatureValidation(param1:Boolean) : void
        {
            m_enableSignatureValidation = param1;
            return;
        }// end function

        private function errored(event:Event) : void
        {
            return;
        }// end function

        private function onData(event:ProgressEvent) : void
        {
            var HEADER_SIZE_BYTES:uint;
            var ZIP_LFH_MAGIC:uint;
            var CDHEADER_SIZE_BYTES:uint;
            var ZIP_CDH_MAGIC:uint;
            var ZIP_CDSIG_MAGIC:uint;
            var magic:uint;
            var filename:ByteArray;
            var versionNeededToExtract:uint;
            var lastModTime:uint;
            var lastModDate:uint;
            var crc32:uint;
            var DATA_DESCRIPTOR_FLAG:uint;
            var COMPRESSION_NONE:uint;
            var COMPRESSION_DEFLATE:uint;
            var elements:Array;
            var numParentDirs:int;
            var parent:Object;
            var currentPath:Array;
            var sizeToRead:uint;
            var i:uint;
            var element:String;
            var shouldContinue:Boolean;
            var fs:FileStream;
            var event:* = event;
            dispatchEvent(event.clone());
            try
            {
                HEADER_SIZE_BYTES;
                ZIP_LFH_MAGIC;
                CDHEADER_SIZE_BYTES;
                ZIP_CDH_MAGIC;
                ZIP_CDSIG_MAGIC;
                while (true)
                {
                    
                    switch(m_ucfParseState)
                    {
                        case AT_START:
                        case AT_HEADER:
                        {
                            if (source.bytesAvailable < HEADER_SIZE_BYTES)
                            {
                                return;
                            }
                            _currentLFH = new ByteArray();
                            _currentLFH.endian = Endian.LITTLE_ENDIAN;
                            source.readBytes(_currentLFH, 0, 4);
                            magic = _currentLFH.readUnsignedInt();
                            if (ZIP_LFH_MAGIC != magic)
                            {
                                if (m_ucfParseState == AT_START)
                                {
                                    throw new Error("not an AIR file", Constants.ERROR_UCF_INVALID_AIR_FILE);
                                }
                                if (ZIP_CDH_MAGIC == magic)
                                {
                                    m_ucfParseState = AT_CDHEADERMAGIC;
                                    break;
                                }
                                m_ucfParseState = AT_END;
                                return;
                            }
                            source.readBytes(_currentLFH, _currentLFH.length, HEADER_SIZE_BYTES - 4);
                            versionNeededToExtract = _currentLFH.readUnsignedShort();
                            _generalPurposeBitFlags = _currentLFH.readUnsignedShort();
                            if ((_generalPurposeBitFlags & 65529) != 0)
                            {
                                throw new Error("file uses unsupported encryption or streaming features", Constants.ERROR_UCF_INVALID_FLAGS);
                            }
                            _compressionMethod = _currentLFH.readUnsignedShort();
                            lastModTime = _currentLFH.readUnsignedShort();
                            lastModDate = _currentLFH.readUnsignedShort();
                            crc32 = _currentLFH.readUnsignedInt();
                            _compressedSize = _currentLFH.readUnsignedInt();
                            _uncompressedSize = _currentLFH.readUnsignedInt();
                            _filenameLength = _currentLFH.readUnsignedShort();
                            _extraFieldLength = _currentLFH.readUnsignedShort();
                            if (_filenameLength == 0)
                            {
                                throw new Error("one of the files has an empty (zero-length) name", Constants.ERROR_UCF_INVALID_FILENAME);
                            }
                            m_ucfParseState = AT_FILENAME;
                        }
                        case AT_FILENAME:
                        {
                            if (source.bytesAvailable < _filenameLength)
                            {
                                return;
                            }
                            source.readBytes(_currentLFH, _currentLFH.length, _filenameLength);
                            filename = new ByteArray();
                            _currentLFH.readBytes(filename, 0, _filenameLength);
                            _path = filename.toString();
                            if (m_fileCount == 0 && _path != "mimetype")
                            {
                                throw new Error("mimetype must be the first file", Constants.ERROR_UCF_NO_MIMETYPE);
                            }
                            DATA_DESCRIPTOR_FLAG;
                            if (_generalPurposeBitFlags & DATA_DESCRIPTOR_FLAG)
                            {
                                throw new Error("file " + _path + " uses a data descriptor field", Constants.ERROR_UCF_INVALID_FLAGS);
                            }
                            COMPRESSION_NONE;
                            COMPRESSION_DEFLATE;
                            if (_compressionMethod != COMPRESSION_DEFLATE && _compressionMethod != COMPRESSION_NONE)
                            {
                                throw new Error("file " + _path + " uses an illegal compression method " + _compressionMethod, Constants.ERROR_UCF_UNKNOWN_COMPRESSION);
                            }
                            isDirectory = _path.charAt(_path.length--) == "/";
                            if (isDirectory)
                            {
                                _path = _path.slice(0, _path.length--);
                            }
                            elements = _path.split("/");
                            if (elements.length == 0)
                            {
                                throw new Error("it contains a file with an empty name", Constants.ERROR_UCF_INVALID_FILENAME);
                            }
                            elements.filter(function (param1, param2:int, param3:Array) : Boolean
            {
                if (param1 == ".")
                {
                    throw new Error("filename " + _path + " contains a component of \'.\'", Constants.ERROR_UCF_INVALID_FILENAME);
                }
                if (param1 == "..")
                {
                    throw new Error("filename " + _path + " contains a component of \'..\'", Constants.ERROR_UCF_INVALID_FILENAME);
                }
                if (param1 == "")
                {
                    throw new Error("filename " + _path + " contains an empty component", Constants.ERROR_UCF_INVALID_FILENAME);
                }
                return true;
            }// end function
            );
                            numParentDirs = isDirectory ? (elements.length) : (elements.length--);
                            parent = _root;
                            currentPath = new Array();
                            i;
                            while (i < numParentDirs)
                            {
                                
                                element = elements[i];
                                currentPath.push(element);
                                if (parent[element] == null)
                                {
                                    parent[element] = new Object();
                                    onDirectory(currentPath.join("/"));
                                }
                                parent = parent[element];
                                i = i++;
                            }
                            m_ucfParseState = AT_EXTRA_FIELD;
                        }
                        case AT_EXTRA_FIELD:
                        {
                            if (source.bytesAvailable < _extraFieldLength)
                            {
                                return;
                            }
                            if (_extraFieldLength > 0)
                            {
                                source.readBytes(_currentLFH, _currentLFH.length, _extraFieldLength);
                            }
                            m_ucfParseState = AT_DATA;
                        }
                        case AT_DATA:
                        {
                            sizeToRead = _compressionMethod == 8 ? (_compressedSize) : (_uncompressedSize);
                            if (source.bytesAvailable < sizeToRead)
                            {
                                return;
                            }
                            if (isDirectory)
                            {
                                if (_uncompressedSize != 0)
                                {
                                    throw new Error("directory entry " + _path + " has associated data", Constants.ERROR_UCF_INVALID_FILENAME);
                                }
                                if (m_dir)
                                {
                                    m_dir.resolvePath(_path).createDirectory();
                                }
                            }
                            else
                            {
                                _data = new ByteArray();
                                if (sizeToRead > 0)
                                {
                                    source.readBytes(_data, 0, sizeToRead);
                                    if (_compressionMethod == 8)
                                    {
                                        _data.uncompress(CompressionAlgorithm.DEFLATE);
                                    }
                                }
                                if (m_dir)
                                {
                                    _data.position = 0;
                                    fs = new FileStream();
                                    fs.open(m_dir.resolvePath(_path), FileMode.WRITE);
                                    fs.writeBytes(_data);
                                    fs.close();
                                }
                                if (m_enableSignatureValidation)
                                {
                                    if (_path == "META-INF/signatures.xml")
                                    {
                                        m_validator.signatures = _data;
                                    }
                                    else
                                    {
                                        m_validator.addFile(_path, _data);
                                    }
                                }
                                shouldContinue = onFile(m_fileCount, _path, _data);
                                if (!shouldContinue)
                                {
                                    m_ucfParseState = AT_ABORTED;
                                    break;
                                }
                            }
                            m_fileCount++;
                            m_ucfParseState = AT_HEADER;
                            break;
                        }
                        case AT_CDHEADER:
                        {
                            if (source.bytesAvailable < 4)
                            {
                                return;
                            }
                            _currentLFH = new ByteArray();
                            _currentLFH.endian = Endian.LITTLE_ENDIAN;
                            source.readBytes(_currentLFH, 0, 4);
                            magic = _currentLFH.readUnsignedInt();
                            if (ZIP_CDH_MAGIC != magic)
                            {
                                m_ucfParseState = AT_END;
                                return;
                            }
                            m_ucfParseState = AT_CDHEADERMAGIC;
                        }
                        case AT_CDHEADERMAGIC:
                        {
                            if (source.bytesAvailable < CDHEADER_SIZE_BYTES - 4)
                            {
                                return;
                            }
                            source.readBytes(_currentLFH, _currentLFH.length, CDHEADER_SIZE_BYTES - 4);
                            _currentLFH.position = _currentLFH.position + 24;
                            _filenameLength = _currentLFH.readUnsignedShort();
                            _extraFieldLength = _currentLFH.readUnsignedShort();
                            _fileCommentLength = _currentLFH.readUnsignedShort();
                            _currentLFH.position = _currentLFH.position + 8;
                            _fileRelativeOffset = _currentLFH.readUnsignedInt();
                            m_ucfParseState = AT_CDFILENAME;
                        }
                        case AT_CDFILENAME:
                        {
                            if (source.bytesAvailable < _filenameLength)
                            {
                                return;
                            }
                            source.readBytes(_currentLFH, _currentLFH.length, _filenameLength);
                            filename = new ByteArray();
                            _currentLFH.readBytes(filename, 0, _filenameLength);
                            _path = filename.toString();
                            m_ucfParseState = AT_CDEXTRA_FIELD;
                        }
                        case AT_CDEXTRA_FIELD:
                        {
                            if (source.bytesAvailable < _extraFieldLength)
                            {
                                return;
                            }
                            if (_extraFieldLength > 0)
                            {
                                source.readBytes(_currentLFH, _currentLFH.length, _extraFieldLength);
                            }
                            m_ucfParseState = AT_CDCOMMENT;
                        }
                        case AT_CDCOMMENT:
                        {
                            if (source.bytesAvailable < _fileCommentLength)
                            {
                                return;
                            }
                            if (_fileCommentLength > 0)
                            {
                                source.readBytes(_currentLFH, _currentLFH.length, _fileCommentLength);
                            }
                            m_ucfParseState = AT_CDHEADER;
                            break;
                        }
                        case AT_END:
                        {
                            return;
                        }
                        case AT_ABORTED:
                        {
                            return;
                        }
                        case AT_ERROR:
                        {
                            return;
                        }
                        default:
                        {
                            break;
                        }
                    }
                }
            }
            catch (e:Error)
            {
                dispatchError(e);
            }
            return;
        }// end function

        private function dispatchError(param1:Error) : void
        {
            m_ucfParseState = AT_ERROR;
            dispatchEvent(new ErrorEvent(ErrorEvent.ERROR, false, false, param1.message, param1.errorID));
            return;
        }// end function

        private function onComplete(event:Event) : void
        {
            var event:* = event;
            try
            {
                switch(m_ucfParseState)
                {
                    case AT_END:
                    {
                        onDone();
                        m_ucfParseState = AT_COMPLETE;
                        if (m_enableSignatureValidation && m_validator.packageSignatureStatus != 0)
                        {
                            dispatchEvent(new ErrorEvent(ErrorEvent.ERROR, false, false, "signature is not valid"));
                            transition(errored);
                        }
                        else
                        {
                            transition(complete);
                        }
                        break;
                    }
                    case AT_ABORTED:
                    {
                        m_isComplete = true;
                        dispatchEvent(new Event(Event.COMPLETE));
                        break;
                    }
                    case AT_ERROR:
                    {
                        break;
                    }
                    default:
                    {
                        throw new Error("truncated or corrupt", Constants.ERROR_UCF_CORRUPT_AIR);
                        break;
                    }
                }
            }
            catch (e:Error)
            {
                dispatchError(e);
            }
            return;
        }// end function

        private function complete(event:Event) : void
        {
            switch(event.type)
            {
                case HSMEvent.ENTER:
                {
                    m_isComplete = true;
                    dispatchEvent(new Event(Event.COMPLETE));
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        protected function onDirectory(param1:String) : void
        {
            return;
        }// end function

        private function initialized(event:Event) : void
        {
            return;
        }// end function

        protected function get ucfParseState() : uint
        {
            return m_ucfParseState;
        }// end function

        public function set outputDirectory(param1:File) : void
        {
            m_dir = param1;
            return;
        }// end function

        public function get outputDirectory() : File
        {
            return m_dir;
        }// end function

        public function unpackageAsync(param1:String) : void
        {
            identifier = param1;
            transitionAsync(unpackaging);
            return;
        }// end function

        public function cancel() : void
        {
            if (source && source.connected)
            {
                source.close();
                m_ucfParseState = AT_ABORTED;
            }
            return;
        }// end function

        protected function onFile(param1:uint, param2:String, param3:ByteArray) : Boolean
        {
            return true;
        }// end function

    }
}
