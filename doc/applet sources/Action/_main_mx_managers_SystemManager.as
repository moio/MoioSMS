package 
{
    import flash.system.*;
    import it.vodafone.*;
    import mx.core.*;
    import mx.managers.*;

    public class _main_mx_managers_SystemManager extends SystemManager implements IFlexModuleFactory
    {

        public function _main_mx_managers_SystemManager()
        {
            return;
        }// end function

        override public function create(... args) : Object
        {
            if (args.length > 0 && !(args[0] is String))
            {
                return super.create.apply(this, args);
            }
            var _loc_2:* = args.length == 0 ? ("main") : (String(args[0]));
            var _loc_3:* = Class(getDefinitionByName(_loc_2));
            if (!_loc_3)
            {
                return null;
            }
            var _loc_4:* = new _loc_3;
            if (new _loc_3 is IFlexModule)
            {
                IFlexModule(_loc_4).moduleFactory = this;
            }
            if (args.length == 0)
            {
                EmbeddedFontRegistry.registerFonts(this.info()["fonts"], this);
            }
            return _loc_4;
        }// end function

        override public function info() : Object
        {
            return {compiledLocales:["en_US"], compiledResourceBundleNames:["collections", "containers", "controls", "core", "effects", "skins", "states", "styles", "utils"], creationComplete:"init()", currentDomain:ApplicationDomain.currentDomain, currentState:"Startup", fonts:{defFont:{regular:true, bold:true, italic:true, boldItalic:true}}, frameRate:"60", height:"378", layout:"absolute", mainClassName:"main", mixins:["_main_FlexInit", "_alertButtonStyleStyle", "_ScrollBarStyle", "_winMaxButtonStyle", "_ToolTipStyle", "_winCloseButtonStyle", "_macCloseButtonStyle", "_comboDropdownStyle", "_CheckBoxStyle", "_gripperSkinStyle", "_winRestoreButtonStyle", "_globalStyle", "_PanelStyle", "_windowStylesStyle", "_activeButtonStyleStyle", "_ApplicationControlBarStyle", "_errorTipStyle", "_CursorManagerStyle", "_dateFieldPopupStyle", "_HRuleStyle", "_dataGridStylesStyle", "_AlertStyle", "_macMinButtonStyle", "_ControlBarStyle", "_activeTabStyleStyle", "_textAreaHScrollBarStyleStyle", "_DragManagerStyle", "_statusTextStyleStyle", "_TextAreaStyle", "_advancedDataGridStylesStyle", "_WindowedApplicationStyle", "_HTMLStyle", "_ContainerStyle", "_textAreaVScrollBarStyleStyle", "_linkButtonStyleStyle", "_windowStatusStyle", "_WindowStyle", "_richTextEditorTextAreaStyleStyle", "_todayStyleStyle", "_TextInputStyle", "_plainStyle", "_winMinButtonStyle", "_macMaxButtonStyle", "_ApplicationStyle", "_SWFLoaderStyle", "_headerDateTextStyle", "_ButtonStyle", "_popUpMenuStyle", "_titleTextStyleStyle", "_swatchPanelTextFieldStyle", "_opaquePanelStyle", "_weekDayStyleStyle", "_headerDragProxyStyleStyle", "_it_vodafone_tooltip_CustomToolTipWatcherSetupUtil", "_it_vodafone_RssTitleWatcherSetupUtil", "_it_vodafone_combo_ComboTestataSelectWatcherSetupUtil", "_it_vodafone_RssWatcherSetupUtil", "_it_vodafone_SaldoPuntiWatcherSetupUtil", "_it_vodafone_rubrica_NomeNumeroWatcherSetupUtil", "_it_vodafone_rubrica_AggiungiContattoWatcherSetupUtil", "_it_vodafone_ultimiNumeri_UltimoNumeroWatcherSetupUtil", "_it_vodafone_SkinWatcherSetupUtil", "_it_vodafone_InfocontoWatcherSetupUtil", "_it_vodafone_LoadingWatcherSetupUtil", "_it_vodafone_SmsWatcherSetupUtil", "_it_vodafone_TestataWatcherSetupUtil", "_it_vodafone_rubrica_RubricaListWatcherSetupUtil", "_it_vodafone_rubrica_RubricaWatcherSetupUtil", "_it_vodafone_ultimiNumeri_UltimiNumeriWatcherSetupUtil", "_it_vodafone_combo_ComboTestataWatcherSetupUtil", "_it_vodafone_ultimiNumeri_UltimiNumeriListWatcherSetupUtil", "_mainWatcherSetupUtil"], preloader:VodafonePreloader, width:"268"};
        }// end function

    }
}
