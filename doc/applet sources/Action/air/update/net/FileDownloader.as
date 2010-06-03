package air.update.net
{
    import air.update.events.*;
    import air.update.logging.*;
    import air.update.utils.*;
    import flash.errors.*;
    import flash.events.*;
    import flash.filesystem.*;
    import flash.net.*;
    import flash.utils.*;

    public class FileDownloader extends EventDispatcher
    {
        private var downloadedFile:File;
        private var urlStream:URLStream;
        private var fileURL:URLRequest;
        private var isInError:Boolean;
        private var fileStream:FileStream;
        private static var logger:Logger = Logger.getLogger("air.update.net.FileDownloader");

        public function FileDownloader(param1:URLRequest, param2:File) : void
        {
            fileURL = param1;
            fileURL.useCache = false;
            downloadedFile = param2;
            logger.finer("url: " + param1.url + " file: " + param2.nativePath);
            urlStream = new URLStream();
            urlStream.addEventListener(IOErrorEvent.IO_ERROR, onDownloadError);
            urlStream.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onDownloadError);
            urlStream.addEventListener(ProgressEvent.PROGRESS, onDownloadProgress);
            urlStream.addEventListener(Event.OPEN, onDownloadOpen);
            urlStream.addEventListener(Event.COMPLETE, onDownloadComplete);
            urlStream.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, onDownloadResponseStatus);
            return;
        }// end function

        private function onDownloadComplete(event:Event) : void
        {
            while (urlStream && urlStream.bytesAvailable)
            {
                
                saveBytes();
            }
            if (urlStream && urlStream.connected)
            {
                urlStream.close();
                urlStream = null;
            }
            fileStream.close();
            fileStream = null;
            if (!isInError)
            {
                dispatchEvent(new UpdateEvent(UpdateEvent.DOWNLOAD_COMPLETE));
            }
            return;
        }// end function

        public function cancel() : void
        {
            try
            {
                if (urlStream && urlStream.connected)
                {
                    urlStream.close();
                }
                if (fileStream)
                {
                    fileStream.close();
                    fileStream = null;
                }
                if (downloadedFile && downloadedFile.exists)
                {
                    downloadedFile.deleteFile();
                }
            }
            catch (e:Error)
            {
                logger.fine("Error during canceling the download: " + e);
            }
            return;
        }// end function

        public function download() : void
        {
            urlStream.load(fileURL);
            return;
        }// end function

        private function onDownloadResponseStatus(event:HTTPStatusEvent) : void
        {
            logger.fine("DownloadStatus: " + event.status);
            if (!NetUtils.isHTTPStatusAcceptable(event.status))
            {
                dispatchErrorEvent("Invalid HTTP status code: " + event.status, Constants.ERROR_INVALID_HTTP_STATUS, event.status);
            }
            return;
        }// end function

        public function inProgress() : Boolean
        {
            return urlStream.connected;
        }// end function

        private function dispatchErrorEvent(param1:String, param2:int = 0, param3:int = 0) : void
        {
            isInError = true;
            if (urlStream && urlStream.connected)
            {
                urlStream.close();
                urlStream = null;
            }
            dispatchEvent(new DownloadErrorEvent(DownloadErrorEvent.DOWNLOAD_ERROR, false, false, param1, param2, param3));
            return;
        }// end function

        private function saveBytes() : void
        {
            var bytes:ByteArray;
            if (!fileStream || !urlStream || !urlStream.connected)
            {
                return;
            }
            try
            {
                bytes = new ByteArray();
                urlStream.readBytes(bytes, 0, urlStream.bytesAvailable);
                fileStream.writeBytes(bytes);
            }
            catch (error:EOFError)
            {
                isInError = true;
                logger.fine("EOFError: " + error);
                dispatchErrorEvent(error.message, Constants.ERROR_EOF_DOWNLOAD, error.errorID);
                ;
            }
            catch (err:IOError)
            {
                isInError = true;
                logger.fine("IOError: " + err);
                dispatchErrorEvent(err.message, Constants.ERROR_IO_FILE, err.errorID);
            }
            return;
        }// end function

        private function onDownloadError(event:ErrorEvent) : void
        {
            if (event is IOErrorEvent)
            {
                dispatchErrorEvent(event.text, Constants.ERROR_IO_DOWNLOAD, event.errorID);
            }
            else if (event is SecurityErrorEvent)
            {
                dispatchErrorEvent(event.text, Constants.ERROR_SECURITY, event.errorID);
            }
            return;
        }// end function

        private function onDownloadOpen(event:Event) : void
        {
            var event:* = event;
            fileStream = new FileStream();
            try
            {
                fileStream.open(downloadedFile, FileMode.WRITE);
            }
            catch (e:Error)
            {
                logger.fine("Error opening file on disk: " + e);
                isInError = true;
                dispatchErrorEvent(e.message, Constants.ERROR_IO_FILE, e.errorID);
                return;
            }
            dispatchEvent(new UpdateEvent(UpdateEvent.DOWNLOAD_START, false, false));
            return;
        }// end function

        private function onDownloadProgress(event:ProgressEvent) : void
        {
            if (!isInError)
            {
                saveBytes();
                dispatchEvent(event);
            }
            return;
        }// end function

    }
}
