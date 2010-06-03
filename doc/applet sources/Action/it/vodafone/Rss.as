package it.vodafone
{
    import flash.events.*;
    import flash.utils.*;
    import mx.binding.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.effects.*;
    import mx.events.*;

    public class Rss extends Canvas implements IBindingClient
    {
        private var isOverScroll:Boolean = false;
        private var _97622025fout1:Fade;
        private var _1264422478ftitle:Label;
        private var _640039539sectionTitle:String = "";
        private var _1414914966allBox:HBox;
        var _watchers:Array;
        private var _97622026fout2:Fade;
        private var autoRetry:Timer;
        private var _264524434contentBox:Canvas;
        var _bindingsByDestination:Object;
        private var _101387fin:Fade;
        var _bindingsBeginWithWord:Object;
        private var currentIndex:int = 0;
        var _bindings:Array;
        private var timerScroll:Timer;
        private var _documentDescriptor_:UIComponentDescriptor;
        private var _3149096fout:Parallel;
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public function Rss()
        {
            this._documentDescriptor_ = new UIComponentDescriptor({type:Canvas, propertiesFactory:function () : Object
            {
                return {width:260, height:40, childDescriptors:[new UIComponentDescriptor({type:Canvas, id:"contentBox", stylesFactory:function () : void
                {
                    this.left = "10";
                    this.right = "10";
                    return;
                }// end function
                , propertiesFactory:function () : Object
                {
                    return {horizontalScrollPolicy:"off", verticalScrollPolicy:"off", height:40, y:0, childDescriptors:[new UIComponentDescriptor({type:Image, stylesFactory:function () : void
                    {
                        this.left = "0";
                        return;
                    }// end function
                    , propertiesFactory:function () : Object
                    {
                        return {scaleContent:false, autoLoad:true, source:"img/v1/bg_rss.png", y:3};
                    }// end function
                    }), new UIComponentDescriptor({type:HBox, id:"allBox", stylesFactory:function () : void
                    {
                        this.verticalAlign = "bottom";
                        this.horizontalGap = 0;
                        this.horizontalAlign = "left";
                        this.top = "19";
                        this.backgroundColor = 16777215;
                        this.backgroundAlpha = 1;
                        return;
                    }// end function
                    , propertiesFactory:function () : Object
                    {
                        return {horizontalScrollPolicy:"off", verticalScrollPolicy:"off", x:3};
                    }// end function
                    }), new UIComponentDescriptor({type:Label, id:"ftitle", stylesFactory:function () : void
                    {
                        this.fontFamily = "defFont";
                        this.fontWeight = "bold";
                        this.fontSize = 12;
                        return;
                    }// end function
                    , propertiesFactory:function () : Object
                    {
                        return {x:18, y:1};
                    }// end function
                    })]};
                }// end function
                })]};
            }// end function
            });
            this._bindings = [];
            this._watchers = [];
            this._bindingsByDestination = {};
            this._bindingsBeginWithWord = {};
            mx_internal::_document = this;
            this.width = 260;
            this.height = 40;
            this.verticalScrollPolicy = "off";
            this.horizontalScrollPolicy = "off";
            this._Rss_Fade1_i();
            this._Rss_Parallel1_i();
            this.addEventListener("initialize", this.___Rss_Canvas1_initialize);
            this.addEventListener("mouseOver", this.___Rss_Canvas1_mouseOver);
            this.addEventListener("mouseOut", this.___Rss_Canvas1_mouseOut);
            return;
        }// end function

        private function inizializzazione() : void
        {
            this.timerScroll = new Timer(50);
            this.timerScroll.addEventListener("timer", this.performScrolling);
            this.autoRetry = new Timer(5000, 1);
            this.autoRetry.addEventListener(TimerEvent.TIMER, this.manageScrolling);
            this.manageScrolling();
            return;
        }// end function

        private function _Rss_Parallel1_i() : Parallel
        {
            var _loc_1:* = new Parallel();
            this.fout = _loc_1;
            _loc_1.children = [this._Rss_Fade2_i(), this._Rss_Fade3_i()];
            return _loc_1;
        }// end function

        public function get fout1() : Fade
        {
            return this._97622025fout1;
        }// end function

        public function get fout2() : Fade
        {
            return this._97622026fout2;
        }// end function

        override public function initialize() : void
        {
            var target:Rss;
            var watcherSetupUtilClass:Object;
            .mx_internal::setDocumentDescriptor(this._documentDescriptor_);
            var bindings:* = this._Rss_bindingsSetup();
            var watchers:Array;
            target;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_it_vodafone_RssWatcherSetupUtil");
                var _loc_2:* = watcherSetupUtilClass;
                _loc_2.watcherSetupUtilClass["init"](null);
            }
            _watcherSetupUtil.setup(this, function (param1:String)
            {
                return target[param1];
            }// end function
            , bindings, watchers);
            var i:uint;
            while (i < bindings.length)
            {
                
                Binding(bindings[i]).execute();
                i = i++;
            }
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            super.initialize();
            return;
        }// end function

        public function get contentBox() : Canvas
        {
            return this._264524434contentBox;
        }// end function

        private function performScrolling(event:TimerEvent) : void
        {
            if (-this.allBox.x > this.allBox.width + 10)
            {
                this.timerScroll.stop();
                this.fout.play();
            }
            if (this.isOverScroll == true)
            {
                this.allBox.x--;
            }
            else
            {
                this.allBox.x = this.allBox.x - 1.8;
            }
            return;
        }// end function

        private function get sectionTitle() : String
        {
            return this._640039539sectionTitle;
        }// end function

        public function set fout1(param1:Fade) : void
        {
            var _loc_2:* = this._97622025fout1;
            if (_loc_2 !== param1)
            {
                this._97622025fout1 = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "fout1", _loc_2, param1));
            }
            return;
        }// end function

        public function get fin() : Fade
        {
            return this._101387fin;
        }// end function

        public function ___Rss_Canvas1_mouseOut(event:MouseEvent) : void
        {
            this.mouseOutScroll();
            return;
        }// end function

        public function mouseOutScroll() : void
        {
            this.isOverScroll = false;
            return;
        }// end function

        public function manageScrolling(event:Event = null) : void
        {
            var _loc_4:RssTitle = null;
            var _loc_6:int = 0;
            var _loc_7:RssData = null;
            var _loc_8:int = 0;
            var _loc_9:RssTitle = null;
            var _loc_10:Timer = null;
            this.autoRetry.stop();
            this.allBox.removeAllChildren();
            this.allBox.alpha = 0;
            this.allBox.x = 0;
            this.ftitle.alpha = 0;
            var _loc_2:Boolean = false;
            var _loc_3:* = RssInterface.getInstance().activeFeeds;
            var _loc_5:int = 0;
            while (_loc_5 < _loc_3.length && _loc_2 == false)
            {
                
                _loc_6 = (_loc_5 + this.currentIndex) % _loc_3.length;
                _loc_7 = RssData(_loc_3[_loc_6]);
                if (_loc_7.loaded && _loc_7.articleCount > 0)
                {
                    _loc_2 = true;
                    this.sectionTitle = _loc_7.titolo;
                    this.currentIndex = _loc_6 + 1;
                    _loc_8 = 0;
                    while (_loc_8 < _loc_7.articleCount)
                    {
                        
                        _loc_4 = new RssTitle();
                        if (_loc_8 < _loc_7.articleCount--)
                        {
                            _loc_4.testo = _loc_7.getArticleTitle(_loc_8) + " •";
                        }
                        else
                        {
                            _loc_4.testo = _loc_7.getArticleTitle(_loc_8);
                        }
                        _loc_4.link = _loc_7.getArticleLink(_loc_8);
                        this.allBox.addChild(_loc_4);
                        _loc_8++;
                    }
                }
                _loc_5++;
            }
            if (true)
            {
                if (_loc_3.length > 0)
                {
                    this.allBox.x = 0;
                    _loc_9 = new RssTitle();
                    _loc_9.testo = "Caricamento...";
                    this.autoRetry.reset();
                    this.autoRetry.start();
                    this.allBox.addChild(_loc_9);
                    this.allBox.alpha = 1;
                }
                else
                {
                    this.allBox.x = -200;
                }
            }
            else
            {
                _loc_10 = new Timer(500, 1);
                _loc_10.addEventListener(TimerEvent.TIMER, this.visualize);
                _loc_10.start();
            }
            return;
        }// end function

        private function visualize(event:Event = null) : void
        {
            this.allBox.x = 0;
            this.fin.play();
            return;
        }// end function

        public function set contentBox(param1:Canvas) : void
        {
            var _loc_2:* = this._264524434contentBox;
            if (_loc_2 !== param1)
            {
                this._264524434contentBox = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "contentBox", _loc_2, param1));
            }
            return;
        }// end function

        public function resumeEffect() : void
        {
            this.timerScroll.start();
            return;
        }// end function

        public function ___Rss_Canvas1_mouseOver(event:MouseEvent) : void
        {
            this.mouseOverScroll();
            return;
        }// end function

        public function get fout() : Parallel
        {
            return this._3149096fout;
        }// end function

        public function holdEffect() : void
        {
            this.timerScroll.stop();
            return;
        }// end function

        private function _Rss_Fade2_i() : Fade
        {
            var _loc_1:* = new Fade();
            this.fout1 = _loc_1;
            _loc_1.alphaFrom = 1;
            _loc_1.alphaTo = 0;
            _loc_1.addEventListener("effectEnd", this.__fout1_effectEnd);
            BindingManager.executeBindings(this, "fout1", this.fout1);
            return _loc_1;
        }// end function

        public function set fin(param1:Fade) : void
        {
            var _loc_2:* = this._101387fin;
            if (_loc_2 !== param1)
            {
                this._101387fin = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "fin", _loc_2, param1));
            }
            return;
        }// end function

        public function ___Rss_Canvas1_initialize(event:FlexEvent) : void
        {
            this.inizializzazione();
            return;
        }// end function

        private function _Rss_bindingsSetup() : Array
        {
            var binding:Binding;
            var result:Array;
            binding = new Binding(this, function () : String
            {
                var _loc_1:* = sectionTitle;
                var _loc_2:* = _loc_1 == undefined ? (null) : (String(_loc_1));
                return _loc_2;
            }// end function
            , function (param1:String) : void
            {
                ftitle.text = param1;
                return;
            }// end function
            , "ftitle.text");
            result[0] = binding;
            binding = new Binding(this, function () : Array
            {
                return [allBox, ftitle];
            }// end function
            , function (param1:Array) : void
            {
                fin.targets = param1;
                return;
            }// end function
            , "fin.targets");
            result[1] = binding;
            binding = new Binding(this, function () : Object
            {
                return ftitle;
            }// end function
            , function (param1:Object) : void
            {
                fout1.target = param1;
                return;
            }// end function
            , "fout1.target");
            result[2] = binding;
            binding = new Binding(this, function () : Object
            {
                return allBox;
            }// end function
            , function (param1:Object) : void
            {
                fout2.target = param1;
                return;
            }// end function
            , "fout2.target");
            result[3] = binding;
            return result;
        }// end function

        public function mouseOverScroll() : void
        {
            this.isOverScroll = true;
            return;
        }// end function

        public function set fout2(param1:Fade) : void
        {
            var _loc_2:* = this._97622026fout2;
            if (_loc_2 !== param1)
            {
                this._97622026fout2 = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "fout2", _loc_2, param1));
            }
            return;
        }// end function

        public function set fout(param1:Parallel) : void
        {
            var _loc_2:* = this._3149096fout;
            if (_loc_2 !== param1)
            {
                this._3149096fout = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "fout", _loc_2, param1));
            }
            return;
        }// end function

        public function set allBox(param1:HBox) : void
        {
            var _loc_2:* = this._1414914966allBox;
            if (_loc_2 !== param1)
            {
                this._1414914966allBox = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allBox", _loc_2, param1));
            }
            return;
        }// end function

        public function refresh() : void
        {
            this.manageScrolling();
            return;
        }// end function

        public function get ftitle() : Label
        {
            return this._1264422478ftitle;
        }// end function

        private function _Rss_bindingExprs() : void
        {
            var _loc_1:* = undefined;
            _loc_1 = this.sectionTitle;
            _loc_1 = [this.allBox, this.ftitle];
            _loc_1 = this.ftitle;
            _loc_1 = this.allBox;
            return;
        }// end function

        public function nascondi() : void
        {
            this.holdEffect();
            return;
        }// end function

        public function get allBox() : HBox
        {
            return this._1414914966allBox;
        }// end function

        public function set ftitle(param1:Label) : void
        {
            var _loc_2:* = this._1264422478ftitle;
            if (_loc_2 !== param1)
            {
                this._1264422478ftitle = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "ftitle", _loc_2, param1));
            }
            return;
        }// end function

        private function _Rss_Fade1_i() : Fade
        {
            var _loc_1:* = new Fade();
            this.fin = _loc_1;
            _loc_1.alphaFrom = 0;
            _loc_1.alphaTo = 1;
            _loc_1.addEventListener("effectEnd", this.__fin_effectEnd);
            BindingManager.executeBindings(this, "fin", this.fin);
            return _loc_1;
        }// end function

        public function __fout1_effectEnd(event:EffectEvent) : void
        {
            this.manageScrolling();
            return;
        }// end function

        private function _Rss_Fade3_i() : Fade
        {
            var _loc_1:* = new Fade();
            this.fout2 = _loc_1;
            _loc_1.alphaFrom = 1;
            _loc_1.alphaTo = 0;
            BindingManager.executeBindings(this, "fout2", this.fout2);
            return _loc_1;
        }// end function

        public function __fin_effectEnd(event:EffectEvent) : void
        {
            this.resumeEffect();
            return;
        }// end function

        private function set sectionTitle(param1:String) : void
        {
            var _loc_2:* = this._640039539sectionTitle;
            if (_loc_2 !== param1)
            {
                this._640039539sectionTitle = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "sectionTitle", _loc_2, param1));
            }
            return;
        }// end function

        public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
        {
            _watcherSetupUtil = param1;
            return;
        }// end function

    }
}
