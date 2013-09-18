set define off
set verify off
set feedback off
WHENEVER SQLERROR EXIT SQL.SQLCODE ROLLBACK
begin wwv_flow.g_import_in_progress := true; end;
/
 
--       AAAA       PPPPP   EEEEEE  XX      XX
--      AA  AA      PP  PP  EE       XX    XX
--     AA    AA     PP  PP  EE        XX  XX
--    AAAAAAAAAA    PPPPP   EEEE       XXXX
--   AA        AA   PP      EE        XX  XX
--  AA          AA  PP      EE       XX    XX
--  AA          AA  PP      EEEEEE  XX      XX
prompt  Set Credentials...
 
begin
 
  -- Assumes you are running the script connected to SQL*Plus as the Oracle user APEX_040200 or as the owner (parsing schema) of the application.
  wwv_flow_api.set_security_group_id(p_security_group_id=>nvl(wwv_flow_application_install.get_workspace_id,55691954624826792581));
 
end;
/

begin wwv_flow.g_import_in_progress := true; end;
/
begin 

select value into wwv_flow_api.g_nls_numeric_chars from nls_session_parameters where parameter='NLS_NUMERIC_CHARACTERS';

end;

/
begin execute immediate 'alter session set nls_numeric_characters=''.,''';

end;

/
begin wwv_flow.g_browser_language := 'en'; end;
/
prompt  Check Compatibility...
 
begin
 
-- This date identifies the minimum version required to import this file.
wwv_flow_api.set_version(p_version_yyyy_mm_dd=>'2012.01.01');
 
end;
/

prompt  Set Application ID...
 
begin
 
   -- SET APPLICATION ID
   wwv_flow.g_flow_id := nvl(wwv_flow_application_install.get_application_id,64237);
   wwv_flow_api.g_id_offset := nvl(wwv_flow_application_install.get_offset,0);
null;
 
end;
/

prompt  ...ui types
--
 
begin
 
null;
 
end;
/

prompt  ...plugins
--
--application/shared_components/plugins/dynamic_action/be_ctb_alertify
 
begin
 
wwv_flow_api.create_plugin (
  p_id => 27896279114572727507 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_type => 'DYNAMIC ACTION'
 ,p_name => 'BE.CTB.ALERTIFY'
 ,p_display_name => 'Alertify'
 ,p_category => 'NOTIFICATION'
 ,p_supported_ui_types => 'DESKTOP:JQM_SMARTPHONE'
 ,p_image_prefix => '#PLUGIN_PREFIX#'
 ,p_plsql_code => 
'function render(p_dynamic_action in apex_plugin.t_dynamic_action'||unistr('\000a')||
'              , p_plugin         in apex_plugin.t_plugin)'||unistr('\000a')||
'return apex_plugin.t_dynamic_action_render_result is'||unistr('\000a')||
'  l_theme                varchar2(4000) := p_plugin.attribute_01;'||unistr('\000a')||
'  l_def_ok_btn_label     varchar2(4000) := p_plugin.attribute_02;'||unistr('\000a')||
'  l_def_cancel_btn_label varchar2(4000) := p_plugin.attribute_03;'||unistr('\000a')||
''||unistr('\000a')||
'  l_message_type       va'||
'rchar2(4000) := p_dynamic_action.attribute_01;'||unistr('\000a')||
'  l_dialog_type        varchar2(4000) := p_dynamic_action.attribute_02;'||unistr('\000a')||
'  l_notification_type  varchar2(4000) := p_dynamic_action.attribute_03;'||unistr('\000a')||
'  l_message            varchar2(4000) := p_dynamic_action.attribute_04;'||unistr('\000a')||
'  l_default_value      varchar2(4000) := p_dynamic_action.attribute_05;'||unistr('\000a')||
'  l_return_into_item   varchar2(4000) := p_dynamic_action.attribu'||
'te_06;'||unistr('\000a')||
'  l_ok_btn_label       varchar2(4000) := p_dynamic_action.attribute_07;'||unistr('\000a')||
'  l_cancel_btn_label   varchar2(4000) := p_dynamic_action.attribute_08;'||unistr('\000a')||
'  l_btn_order          varchar2(4000) := p_dynamic_action.attribute_09;'||unistr('\000a')||
'  l_btn_focus          varchar2(4000) := p_dynamic_action.attribute_10;'||unistr('\000a')||
'  l_notification_delay varchar2(4000) := p_dynamic_action.attribute_11;'||unistr('\000a')||
''||unistr('\000a')||
'  l_function_call varchar2(4000)'||
';'||unistr('\000a')||
'  l_render_result apex_plugin.t_dynamic_action_render_result;'||unistr('\000a')||
''||unistr('\000a')||
''||unistr('\000a')||
'  function get_properties'||unistr('\000a')||
'  return varchar2 is'||unistr('\000a')||
'    l_ok_label     varchar2(4000);'||unistr('\000a')||
'    l_cancel_label varchar2(4000);'||unistr('\000a')||
'    l_props        varchar2(32767);'||unistr('\000a')||
'  begin'||unistr('\000a')||
'    l_ok_label := nvl(l_ok_btn_label, nvl(l_def_ok_btn_label, ''OK''));'||unistr('\000a')||
'    l_cancel_label := nvl(l_cancel_btn_label, nvl(l_def_cancel_btn_label, ''Cancel''));'||unistr('\000a')||
''||unistr('\000a')||
'    l_props := '''||
'alertify.set({labels:{ok:"'' || l_ok_label || ''",cancel:"'' || l_cancel_label || ''"},'';'||unistr('\000a')||
''||unistr('\000a')||
'    if (l_dialog_type = ''ALERT'') then'||unistr('\000a')||
'      l_props := l_props || ''buttonReverse:false,buttonFocus:"ok"'';'||unistr('\000a')||
'    else'||unistr('\000a')||
'      if (l_btn_order = ''REVERSE'') then'||unistr('\000a')||
'        l_props := l_props || ''buttonReverse:true,'';'||unistr('\000a')||
'      else'||unistr('\000a')||
'        l_props := l_props || ''buttonReverse:false,'';'||unistr('\000a')||
'      end if;'||unistr('\000a')||
''||unistr('\000a')||
'      if (l_btn_focus = '''||
'OK'') then'||unistr('\000a')||
'        l_props := l_props || ''buttonFocus:"ok"'';'||unistr('\000a')||
'      elsif (l_btn_focus = ''CANCEL'') then'||unistr('\000a')||
'        l_props := l_props || ''buttonFocus:"cancel"'';'||unistr('\000a')||
'      else'||unistr('\000a')||
'        l_props := l_props || ''buttonFocus:"none"'';'||unistr('\000a')||
'      end if;'||unistr('\000a')||
'    end if;'||unistr('\000a')||
''||unistr('\000a')||
'    l_props := l_props || ''});'';'||unistr('\000a')||
''||unistr('\000a')||
'    return l_props;'||unistr('\000a')||
'  end get_properties;'||unistr('\000a')||
'begin'||unistr('\000a')||
'  if (apex_application.g_debug) then'||unistr('\000a')||
'    apex_plugin_util.debug_dynamic_'||
'action(p_plugin, p_dynamic_action);'||unistr('\000a')||
'  end if;'||unistr('\000a')||
''||unistr('\000a')||
'  apex_javascript.add_library('||unistr('\000a')||
'    p_name      => ''alertify.min'','||unistr('\000a')||
'    p_directory => p_plugin.file_prefix,'||unistr('\000a')||
'    p_version   => null'||unistr('\000a')||
'  );'||unistr('\000a')||
'  apex_javascript.add_library('||unistr('\000a')||
'    p_name      => ''apex.alertify'','||unistr('\000a')||
'    p_directory => p_plugin.file_prefix,'||unistr('\000a')||
'    p_version   => null'||unistr('\000a')||
'  );'||unistr('\000a')||
'  apex_css.add_file('||unistr('\000a')||
'    p_name      => ''alertify.core'','||unistr('\000a')||
'    p_directory => p_pl'||
'ugin.file_prefix,'||unistr('\000a')||
'    p_version   => null'||unistr('\000a')||
'  );'||unistr('\000a')||
'  if (l_theme = ''DEFAULT'') then'||unistr('\000a')||
'    apex_css.add_file('||unistr('\000a')||
'      p_name      => ''alertify.default'','||unistr('\000a')||
'      p_directory => p_plugin.file_prefix,'||unistr('\000a')||
'      p_version   => null'||unistr('\000a')||
'    );'||unistr('\000a')||
'  else'||unistr('\000a')||
'    apex_css.add_file('||unistr('\000a')||
'      p_name      => ''alertify.bootstrap'','||unistr('\000a')||
'      p_directory => p_plugin.file_prefix,'||unistr('\000a')||
'      p_version   => null'||unistr('\000a')||
'    );'||unistr('\000a')||
'  end if;'||unistr('\000a')||
''||unistr('\000a')||
'  l_render_result.att'||
'ribute_03 := l_notification_type;'||unistr('\000a')||
'  l_render_result.attribute_04 := l_message;'||unistr('\000a')||
'  l_render_result.attribute_05 := l_default_value;'||unistr('\000a')||
'  l_render_result.attribute_06 := l_return_into_item;'||unistr('\000a')||
'  l_render_result.attribute_11 := nvl(l_notification_delay, 5000);'||unistr('\000a')||
''||unistr('\000a')||
'  if (l_message_type = ''DIALOG'') then'||unistr('\000a')||
'    if (l_dialog_type = ''ALERT'') then'||unistr('\000a')||
'      l_function_call := ''beCtbAlertify.dialog.alert(this);'';'||unistr('\000a')||
'    elsif '||
'(l_dialog_type = ''CONFIRM'') then'||unistr('\000a')||
'      l_function_call := ''beCtbAlertify.dialog.confirm(this);'';'||unistr('\000a')||
'    else'||unistr('\000a')||
'      l_function_call := ''beCtbAlertify.dialog.prompt(this);'';'||unistr('\000a')||
'    end if;'||unistr('\000a')||
'    l_render_result.javascript_function := ''function() {'' || get_properties || '' '' || l_function_call || ''}'';'||unistr('\000a')||
'  else'||unistr('\000a')||
'    l_function_call := ''beCtbAlertify.notification.log(this);'';'||unistr('\000a')||
'    l_render_result.javascript_functio'||
'n := ''function() {'' || l_function_call || ''}'';'||unistr('\000a')||
'  end if;'||unistr('\000a')||
''||unistr('\000a')||
'  return l_render_result;'||unistr('\000a')||
'end render;'
 ,p_render_function => 'render'
 ,p_standard_attributes => 'ONLOAD:WAIT_FOR_RESULT'
 ,p_substitute_attributes => true
 ,p_subscribe_plugin_settings => true
 ,p_version_identifier => '1.0'
 ,p_about_url => 'http://apex.oracle.com/pls/apex/f?p=64237:30'
  );
wwv_flow_api.create_plugin_attribute (
  p_id => 27896356122539674419 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_id => 27896279114572727507 + wwv_flow_api.g_id_offset
 ,p_attribute_scope => 'APPLICATION'
 ,p_attribute_sequence => 1
 ,p_display_sequence => 10
 ,p_prompt => 'Theme'
 ,p_attribute_type => 'SELECT LIST'
 ,p_is_required => true
 ,p_default_value => 'DEFAULT'
 ,p_is_translatable => false
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 27896357920598675378 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 27896356122539674419 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 10
 ,p_display_value => 'Default'
 ,p_return_value => 'DEFAULT'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 27896399818011676582 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 27896356122539674419 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 20
 ,p_display_value => 'Twitter Bootstrap'
 ,p_return_value => 'BOOTSTRAP'
  );
wwv_flow_api.create_plugin_attribute (
  p_id => 27912652519246138226 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_id => 27896279114572727507 + wwv_flow_api.g_id_offset
 ,p_attribute_scope => 'APPLICATION'
 ,p_attribute_sequence => 2
 ,p_display_sequence => 20
 ,p_prompt => 'OK Button Label'
 ,p_attribute_type => 'TEXT'
 ,p_is_required => false
 ,p_display_length => 15
 ,p_is_translatable => true
  );
wwv_flow_api.create_plugin_attribute (
  p_id => 27912675814070140586 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_id => 27896279114572727507 + wwv_flow_api.g_id_offset
 ,p_attribute_scope => 'APPLICATION'
 ,p_attribute_sequence => 3
 ,p_display_sequence => 30
 ,p_prompt => 'Cancel Button Label'
 ,p_attribute_type => 'TEXT'
 ,p_is_required => false
 ,p_display_length => 15
 ,p_is_translatable => true
  );
wwv_flow_api.create_plugin_attribute (
  p_id => 27896456907228681537 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_id => 27896279114572727507 + wwv_flow_api.g_id_offset
 ,p_attribute_scope => 'COMPONENT'
 ,p_attribute_sequence => 1
 ,p_display_sequence => 10
 ,p_prompt => 'Message Type'
 ,p_attribute_type => 'SELECT LIST'
 ,p_is_required => true
 ,p_default_value => 'DIALOG'
 ,p_is_translatable => false
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 27896461102914683572 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 27896456907228681537 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 10
 ,p_display_value => 'Dialog'
 ,p_return_value => 'DIALOG'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 27896470100542684617 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 27896456907228681537 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 20
 ,p_display_value => 'Notification'
 ,p_return_value => 'NOTIFICATION'
  );
wwv_flow_api.create_plugin_attribute (
  p_id => 27896592322527689632 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_id => 27896279114572727507 + wwv_flow_api.g_id_offset
 ,p_attribute_scope => 'COMPONENT'
 ,p_attribute_sequence => 2
 ,p_display_sequence => 20
 ,p_prompt => 'Dialog Type'
 ,p_attribute_type => 'SELECT LIST'
 ,p_is_required => true
 ,p_default_value => 'ALERT'
 ,p_is_translatable => false
 ,p_depending_on_attribute_id => 27896456907228681537 + wwv_flow_api.g_id_offset
 ,p_depending_on_condition_type => 'EQUALS'
 ,p_depending_on_expression => 'DIALOG'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 27896598921017690391 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 27896592322527689632 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 10
 ,p_display_value => 'Alert'
 ,p_return_value => 'ALERT'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 27896601618861691345 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 27896592322527689632 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 20
 ,p_display_value => 'Confirm'
 ,p_return_value => 'CONFIRM'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 27896665016057692681 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 27896592322527689632 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 30
 ,p_display_value => 'Prompt'
 ,p_return_value => 'PROMPT'
  );
wwv_flow_api.create_plugin_attribute (
  p_id => 27896672105706697443 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_id => 27896279114572727507 + wwv_flow_api.g_id_offset
 ,p_attribute_scope => 'COMPONENT'
 ,p_attribute_sequence => 3
 ,p_display_sequence => 30
 ,p_prompt => 'Notification Type'
 ,p_attribute_type => 'SELECT LIST'
 ,p_is_required => true
 ,p_default_value => 'STANDARD'
 ,p_is_translatable => false
 ,p_depending_on_attribute_id => 27896456907228681537 + wwv_flow_api.g_id_offset
 ,p_depending_on_condition_type => 'EQUALS'
 ,p_depending_on_expression => 'NOTIFICATION'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 27896359903980762817 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 27896672105706697443 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 10
 ,p_display_value => 'Standard'
 ,p_return_value => 'STANDARD'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 27896675702039699125 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 27896672105706697443 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 20
 ,p_display_value => 'Success'
 ,p_return_value => 'SUCCESS'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 27896682000314699979 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 27896672105706697443 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 30
 ,p_display_value => 'Error'
 ,p_return_value => 'ERROR'
  );
wwv_flow_api.create_plugin_attribute (
  p_id => 27896693918202706806 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_id => 27896279114572727507 + wwv_flow_api.g_id_offset
 ,p_attribute_scope => 'COMPONENT'
 ,p_attribute_sequence => 4
 ,p_display_sequence => 40
 ,p_prompt => 'Message'
 ,p_attribute_type => 'TEXT'
 ,p_is_required => true
 ,p_is_translatable => true
 ,p_help_text => '<p>The following substitution syntax is available:</p>'||unistr('\000a')||
''||unistr('\000a')||
'<ul>'||unistr('\000a')||
'  <li>Static substitution: replaces a placeholder during rendering of the page - e.g. &amp;P30_PROMPT_RESULT.</li>'||unistr('\000a')||
'  <li>Dynamic substitution: replaces a placeholder with the current value of the browser - e.g. #P30_PROMPT_RESULT#</li>'||unistr('\000a')||
'</ul>'
  );
wwv_flow_api.create_plugin_attribute (
  p_id => 27896743107634776318 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_id => 27896279114572727507 + wwv_flow_api.g_id_offset
 ,p_attribute_scope => 'COMPONENT'
 ,p_attribute_sequence => 5
 ,p_display_sequence => 50
 ,p_prompt => 'Default Value'
 ,p_attribute_type => 'TEXT'
 ,p_is_required => false
 ,p_is_translatable => true
 ,p_depending_on_attribute_id => 27896592322527689632 + wwv_flow_api.g_id_offset
 ,p_depending_on_condition_type => 'EQUALS'
 ,p_depending_on_expression => 'PROMPT'
 ,p_help_text => '<p>The following substitution syntax is available:</p>'||unistr('\000a')||
''||unistr('\000a')||
'<ul>'||unistr('\000a')||
'  <li>Static substitution: replaces a placeholder during rendering of the page - e.g. &amp;P30_PROMPT_RESULT.</li>'||unistr('\000a')||
'  <li>Dynamic substitution: replaces a placeholder with the current value of the browser - e.g. #P30_PROMPT_RESULT#</li>'||unistr('\000a')||
'</ul>'
  );
wwv_flow_api.create_plugin_attribute (
  p_id => 27897011111719725012 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_id => 27896279114572727507 + wwv_flow_api.g_id_offset
 ,p_attribute_scope => 'COMPONENT'
 ,p_attribute_sequence => 6
 ,p_display_sequence => 60
 ,p_prompt => 'Return Value Into Item'
 ,p_attribute_type => 'PAGE ITEM'
 ,p_is_required => true
 ,p_is_translatable => false
 ,p_depending_on_attribute_id => 27896592322527689632 + wwv_flow_api.g_id_offset
 ,p_depending_on_condition_type => 'EQUALS'
 ,p_depending_on_expression => 'PROMPT'
 ,p_help_text => 'The value entered in the prompt box will be returned in the item you select.'
  );
wwv_flow_api.create_plugin_attribute (
  p_id => 27897292928313732535 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_id => 27896279114572727507 + wwv_flow_api.g_id_offset
 ,p_attribute_scope => 'COMPONENT'
 ,p_attribute_sequence => 7
 ,p_display_sequence => 70
 ,p_prompt => 'OK Button Label'
 ,p_attribute_type => 'TEXT'
 ,p_is_required => false
 ,p_display_length => 15
 ,p_is_translatable => true
 ,p_depending_on_attribute_id => 27896456907228681537 + wwv_flow_api.g_id_offset
 ,p_depending_on_condition_type => 'EQUALS'
 ,p_depending_on_expression => 'DIALOG'
  );
wwv_flow_api.create_plugin_attribute (
  p_id => 27897377922274735334 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_id => 27896279114572727507 + wwv_flow_api.g_id_offset
 ,p_attribute_scope => 'COMPONENT'
 ,p_attribute_sequence => 8
 ,p_display_sequence => 80
 ,p_prompt => 'Cancel Button Label'
 ,p_attribute_type => 'TEXT'
 ,p_is_required => false
 ,p_display_length => 15
 ,p_is_translatable => true
 ,p_depending_on_attribute_id => 27896592322527689632 + wwv_flow_api.g_id_offset
 ,p_depending_on_condition_type => 'NOT_EQUALS'
 ,p_depending_on_expression => 'ALERT'
  );
wwv_flow_api.create_plugin_attribute (
  p_id => 27897387422909750200 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_id => 27896279114572727507 + wwv_flow_api.g_id_offset
 ,p_attribute_scope => 'COMPONENT'
 ,p_attribute_sequence => 9
 ,p_display_sequence => 90
 ,p_prompt => 'Button Order'
 ,p_attribute_type => 'SELECT LIST'
 ,p_is_required => true
 ,p_default_value => 'DEFAULT'
 ,p_is_translatable => false
 ,p_depending_on_attribute_id => 27896592322527689632 + wwv_flow_api.g_id_offset
 ,p_depending_on_condition_type => 'IN_LIST'
 ,p_depending_on_expression => 'CONFIRM,PROMPT'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 27897438231079841358 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 27897387422909750200 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 10
 ,p_display_value => 'Cancel - OK'
 ,p_return_value => 'DEFAULT'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 27897443328276842634 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 27897387422909750200 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 20
 ,p_display_value => 'OK - Cancel'
 ,p_return_value => 'REVERSE'
  );
wwv_flow_api.create_plugin_attribute (
  p_id => 27897490206494852755 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_id => 27896279114572727507 + wwv_flow_api.g_id_offset
 ,p_attribute_scope => 'COMPONENT'
 ,p_attribute_sequence => 10
 ,p_display_sequence => 100
 ,p_prompt => 'Button Focus'
 ,p_attribute_type => 'SELECT LIST'
 ,p_is_required => true
 ,p_default_value => 'OK'
 ,p_is_translatable => false
 ,p_depending_on_attribute_id => 27896592322527689632 + wwv_flow_api.g_id_offset
 ,p_depending_on_condition_type => 'IN_LIST'
 ,p_depending_on_expression => 'CONFIRM,PROMPT'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 27897607005200853426 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 27897490206494852755 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 10
 ,p_display_value => 'OK'
 ,p_return_value => 'OK'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 27897607703690854053 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 27897490206494852755 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 20
 ,p_display_value => 'Cancel'
 ,p_return_value => 'CANCEL'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 27897620400240791135 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 27897490206494852755 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 30
 ,p_display_value => 'None'
 ,p_return_value => 'NONE'
  );
wwv_flow_api.create_plugin_attribute (
  p_id => 27897651513167864886 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_id => 27896279114572727507 + wwv_flow_api.g_id_offset
 ,p_attribute_scope => 'COMPONENT'
 ,p_attribute_sequence => 11
 ,p_display_sequence => 110
 ,p_prompt => 'Delay in Milliseconds'
 ,p_attribute_type => 'INTEGER'
 ,p_is_required => false
 ,p_display_length => 10
 ,p_is_translatable => false
 ,p_depending_on_attribute_id => 27896456907228681537 + wwv_flow_api.g_id_offset
 ,p_depending_on_condition_type => 'EQUALS'
 ,p_depending_on_expression => 'NOTIFICATION'
 ,p_help_text => 'The default delay is 5000 milliseconds. Enter 0 if you want to display a sticky notification.'
  );
null;
 
end;
/

 
begin
 
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '2F2A2120616C657274696679202D2076302E332E3130202D20323031332D30372D3036202A2F0A2166756E6374696F6E28612C62297B2275736520737472696374223B76617220632C643D612E646F63756D656E743B633D66756E6374696F6E28297B76';
wwv_flow_api.g_varchar2_table(2) := '617220632C652C662C672C682C692C6A2C6B2C6C2C6D2C6E2C6F2C703D7B7D2C713D7B7D2C723D21312C733D7B454E5445523A31332C4553433A32372C53504143453A33327D2C743D5B5D3B72657475726E20713D7B627574746F6E733A7B686F6C6465';
wwv_flow_api.g_varchar2_table(3) := '723A273C6E617620636C6173733D22616C6572746966792D627574746F6E73223E7B7B627574746F6E737D7D3C2F6E61763E272C7375626D69743A273C627574746F6E20747970653D227375626D69742220636C6173733D22616C6572746966792D6275';
wwv_flow_api.g_varchar2_table(4) := '74746F6E20616C6572746966792D627574746F6E2D6F6B222069643D22616C6572746966792D6F6B223E7B7B6F6B7D7D3C2F627574746F6E3E272C6F6B3A273C627574746F6E20636C6173733D22616C6572746966792D627574746F6E20616C65727469';
wwv_flow_api.g_varchar2_table(5) := '66792D627574746F6E2D6F6B222069643D22616C6572746966792D6F6B223E7B7B6F6B7D7D3C2F627574746F6E3E272C63616E63656C3A273C627574746F6E20636C6173733D22616C6572746966792D627574746F6E20616C6572746966792D62757474';
wwv_flow_api.g_varchar2_table(6) := '6F6E2D63616E63656C222069643D22616C6572746966792D63616E63656C223E7B7B63616E63656C7D7D3C2F627574746F6E3E277D2C696E7075743A273C64697620636C6173733D22616C6572746966792D746578742D77726170706572223E3C696E70';
wwv_flow_api.g_varchar2_table(7) := '757420747970653D22746578742220636C6173733D22616C6572746966792D74657874222069643D22616C6572746966792D74657874223E3C2F6469763E272C6D6573736167653A273C7020636C6173733D22616C6572746966792D6D65737361676522';
wwv_flow_api.g_varchar2_table(8) := '3E7B7B6D6573736167657D7D3C2F703E272C6C6F673A273C61727469636C6520636C6173733D22616C6572746966792D6C6F677B7B636C6173737D7D223E7B7B6D6573736167657D7D3C2F61727469636C653E277D2C6F3D66756E6374696F6E28297B76';
wwv_flow_api.g_varchar2_table(9) := '617220612C632C653D21312C663D642E637265617465456C656D656E74282266616B65656C656D656E7422292C673D7B5765626B69745472616E736974696F6E3A227765626B69745472616E736974696F6E456E64222C4D6F7A5472616E736974696F6E';
wwv_flow_api.g_varchar2_table(10) := '3A227472616E736974696F6E656E64222C4F5472616E736974696F6E3A226F7472616E736974696F6E656E64222C7472616E736974696F6E3A227472616E736974696F6E656E64227D3B666F72286120696E206729696628662E7374796C655B615D213D';
wwv_flow_api.g_varchar2_table(11) := '3D62297B633D675B615D2C653D21303B627265616B7D72657475726E7B747970653A632C737570706F727465643A657D7D2C633D66756E6374696F6E2861297B72657475726E20642E676574456C656D656E74427949642861297D2C703D7B6C6162656C';
wwv_flow_api.g_varchar2_table(12) := '733A7B6F6B3A224F4B222C63616E63656C3A2243616E63656C227D2C64656C61793A3565332C627574746F6E526576657273653A21312C627574746F6E466F6375733A226F6B222C7472616E736974696F6E3A622C6164644C697374656E6572733A6675';
wwv_flow_api.g_varchar2_table(13) := '6E6374696F6E2861297B76617220622C632C682C692C6A2C6B3D22756E646566696E656422213D747970656F6620662C6C3D22756E646566696E656422213D747970656F6620652C6F3D22756E646566696E656422213D747970656F66206E2C703D2222';
wwv_flow_api.g_varchar2_table(14) := '2C713D746869733B623D66756E6374696F6E2862297B72657475726E22756E646566696E656422213D747970656F6620622E70726576656E7444656661756C742626622E70726576656E7444656661756C7428292C682862292C22756E646566696E6564';
wwv_flow_api.g_varchar2_table(15) := '22213D747970656F66206E262628703D6E2E76616C7565292C2266756E6374696F6E223D3D747970656F66206126262822756E646566696E656422213D747970656F66206E3F612821302C70293A6128213029292C21317D2C633D66756E6374696F6E28';
wwv_flow_api.g_varchar2_table(16) := '62297B72657475726E22756E646566696E656422213D747970656F6620622E70726576656E7444656661756C742626622E70726576656E7444656661756C7428292C682862292C2266756E6374696F6E223D3D747970656F662061262661282131292C21';
wwv_flow_api.g_varchar2_table(17) := '317D2C683D66756E6374696F6E28297B712E6869646528292C712E756E62696E6428642E626F64792C226B65797570222C69292C712E756E62696E6428672C22666F637573222C6A292C6F2626712E756E62696E64286D2C227375626D6974222C62292C';
wwv_flow_api.g_varchar2_table(18) := '6B2626712E756E62696E6428662C22636C69636B222C62292C6C2626712E756E62696E6428652C22636C69636B222C63297D2C693D66756E6374696F6E2861297B76617220643D612E6B6579436F64653B64213D3D732E53504143457C7C6F7C7C622861';
wwv_flow_api.g_varchar2_table(19) := '292C643D3D3D732E45534326266C2626632861297D2C6A3D66756E6374696F6E28297B6F3F6E2E666F63757328293A216C7C7C712E627574746F6E526576657273653F662E666F63757328293A652E666F63757328297D2C746869732E62696E6428672C';
wwv_flow_api.g_varchar2_table(20) := '22666F637573222C6A292C6B2626746869732E62696E6428662C22636C69636B222C62292C6C2626746869732E62696E6428652C22636C69636B222C63292C746869732E62696E6428642E626F64792C226B65797570222C69292C6F2626746869732E62';
wwv_flow_api.g_varchar2_table(21) := '696E64286D2C227375626D6974222C62292C746869732E7472616E736974696F6E2E737570706F727465647C7C746869732E736574466F63757328297D2C62696E643A66756E6374696F6E28612C622C63297B2266756E6374696F6E223D3D747970656F';
wwv_flow_api.g_varchar2_table(22) := '6620612E6164644576656E744C697374656E65723F612E6164644576656E744C697374656E657228622C632C2131293A612E6174746163684576656E742626612E6174746163684576656E7428226F6E222B622C63297D2C68616E646C654572726F7273';
wwv_flow_api.g_varchar2_table(23) := '3A66756E6374696F6E28297B69662822756E646566696E656422213D747970656F6620612E6F6E6572726F72297B76617220623D746869733B72657475726E20612E6F6E6572726F723D66756E6374696F6E28612C632C64297B622E6572726F7228225B';
wwv_flow_api.g_varchar2_table(24) := '222B612B22206F6E206C696E6520222B642B22206F6620222B632B225D222C30297D2C21307D72657475726E21317D2C617070656E64427574746F6E733A66756E6374696F6E28612C62297B72657475726E20746869732E627574746F6E526576657273';
wwv_flow_api.g_varchar2_table(25) := '653F622B613A612B627D2C6275696C643A66756E6374696F6E2861297B76617220623D22222C633D612E747970652C643D612E6D6573736167652C653D612E637373436C6173737C7C22223B73776974636828622B3D273C64697620636C6173733D2261';
wwv_flow_api.g_varchar2_table(26) := '6C6572746966792D6469616C6F67223E272C226E6F6E65223D3D3D702E627574746F6E466F637573262628622B3D273C6120687265663D2223222069643D22616C6572746966792D6E6F6E65466F6375732220636C6173733D22616C6572746966792D68';
wwv_flow_api.g_varchar2_table(27) := '696464656E223E3C2F613E27292C2270726F6D7074223D3D3D63262628622B3D273C666F726D2069643D22616C6572746966792D666F726D223E27292C622B3D273C61727469636C6520636C6173733D22616C6572746966792D696E6E6572223E272C62';
wwv_flow_api.g_varchar2_table(28) := '2B3D712E6D6573736167652E7265706C61636528227B7B6D6573736167657D7D222C64292C2270726F6D7074223D3D3D63262628622B3D712E696E707574292C622B3D712E627574746F6E732E686F6C6465722C622B3D223C2F61727469636C653E222C';
wwv_flow_api.g_varchar2_table(29) := '2270726F6D7074223D3D3D63262628622B3D223C2F666F726D3E22292C622B3D273C612069643D22616C6572746966792D7265736574466F6375732220636C6173733D22616C6572746966792D7265736574466F6375732220687265663D2223223E5265';
wwv_flow_api.g_varchar2_table(30) := '73657420466F6375733C2F613E272C622B3D223C2F6469763E222C63297B6361736522636F6E6669726D223A623D622E7265706C61636528227B7B627574746F6E737D7D222C746869732E617070656E64427574746F6E7328712E627574746F6E732E63';
wwv_flow_api.g_varchar2_table(31) := '616E63656C2C712E627574746F6E732E6F6B29292C623D622E7265706C61636528227B7B6F6B7D7D222C746869732E6C6162656C732E6F6B292E7265706C61636528227B7B63616E63656C7D7D222C746869732E6C6162656C732E63616E63656C293B62';
wwv_flow_api.g_varchar2_table(32) := '7265616B3B636173652270726F6D7074223A623D622E7265706C61636528227B7B627574746F6E737D7D222C746869732E617070656E64427574746F6E7328712E627574746F6E732E63616E63656C2C712E627574746F6E732E7375626D697429292C62';
wwv_flow_api.g_varchar2_table(33) := '3D622E7265706C61636528227B7B6F6B7D7D222C746869732E6C6162656C732E6F6B292E7265706C61636528227B7B63616E63656C7D7D222C746869732E6C6162656C732E63616E63656C293B627265616B3B6361736522616C657274223A623D622E72';
wwv_flow_api.g_varchar2_table(34) := '65706C61636528227B7B627574746F6E737D7D222C712E627574746F6E732E6F6B292C623D622E7265706C61636528227B7B6F6B7D7D222C746869732E6C6162656C732E6F6B297D72657475726E206B2E636C6173734E616D653D22616C657274696679';
wwv_flow_api.g_varchar2_table(35) := '20616C6572746966792D222B632B2220222B652C6A2E636C6173734E616D653D22616C6572746966792D636F766572222C627D2C636C6F73653A66756E6374696F6E28612C62297B76617220632C642C653D6226262169734E614E2862293F2B623A7468';
wwv_flow_api.g_varchar2_table(36) := '69732E64656C61792C663D746869733B746869732E62696E6428612C22636C69636B222C66756E6374696F6E28297B632861297D292C643D66756E6374696F6E2861297B612E73746F7050726F7061676174696F6E28292C662E756E62696E6428746869';
wwv_flow_api.g_varchar2_table(37) := '732C662E7472616E736974696F6E2E747970652C64292C6C2E72656D6F76654368696C642874686973292C6C2E6861734368696C644E6F64657328297C7C286C2E636C6173734E616D652B3D2220616C6572746966792D6C6F67732D68696464656E2229';
wwv_flow_api.g_varchar2_table(38) := '7D2C633D66756E6374696F6E2861297B22756E646566696E656422213D747970656F6620612626612E706172656E744E6F64653D3D3D6C262628662E7472616E736974696F6E2E737570706F727465643F28662E62696E6428612C662E7472616E736974';
wwv_flow_api.g_varchar2_table(39) := '696F6E2E747970652C64292C612E636C6173734E616D652B3D2220616C6572746966792D6C6F672D6869646522293A286C2E72656D6F76654368696C642861292C6C2E6861734368696C644E6F64657328297C7C286C2E636C6173734E616D652B3D2220';
wwv_flow_api.g_varchar2_table(40) := '616C6572746966792D6C6F67732D68696464656E222929297D2C30213D3D62262673657454696D656F75742866756E6374696F6E28297B632861297D2C65297D2C6469616C6F673A66756E6374696F6E28612C622C632C652C66297B693D642E61637469';
wwv_flow_api.g_varchar2_table(41) := '7665456C656D656E743B76617220673D66756E6374696F6E28297B6C26266E756C6C213D3D6C2E7363726F6C6C546F7026266A26266E756C6C213D3D6A2E7363726F6C6C546F707C7C6728297D3B69662822737472696E6722213D747970656F66206129';
wwv_flow_api.g_varchar2_table(42) := '7468726F77206E6577204572726F7228226D657373616765206D757374206265206120737472696E6722293B69662822737472696E6722213D747970656F662062297468726F77206E6577204572726F72282274797065206D7573742062652061207374';
wwv_flow_api.g_varchar2_table(43) := '72696E6722293B69662822756E646566696E656422213D747970656F66206326262266756E6374696F6E22213D747970656F662063297468726F77206E6577204572726F722822666E206D75737420626520612066756E6374696F6E22293B7265747572';
wwv_flow_api.g_varchar2_table(44) := '6E2266756E6374696F6E223D3D747970656F6620746869732E696E6974262628746869732E696E697428292C672829292C742E70757368287B747970653A622C6D6573736167653A612C63616C6C6261636B3A632C706C616365686F6C6465723A652C63';
wwv_flow_api.g_varchar2_table(45) := '7373436C6173733A667D292C727C7C746869732E736574757028292C746869737D2C657874656E643A66756E6374696F6E2861297B69662822737472696E6722213D747970656F662061297468726F77206E6577204572726F722822657874656E64206D';
wwv_flow_api.g_varchar2_table(46) := '6574686F64206D75737420686176652065786163746C79206F6E6520706172616D74657222293B72657475726E2066756E6374696F6E28622C63297B72657475726E20746869732E6C6F6728622C612C63292C746869737D7D2C686964653A66756E6374';
wwv_flow_api.g_varchar2_table(47) := '696F6E28297B76617220612C623D746869733B742E73706C69636528302C31292C742E6C656E6774683E303F746869732E7365747570282130293A28723D21312C613D66756E6374696F6E2863297B632E73746F7050726F7061676174696F6E28292C6B';
wwv_flow_api.g_varchar2_table(48) := '2E636C6173734E616D652B3D2220616C6572746966792D697348696464656E222C622E756E62696E64286B2C622E7472616E736974696F6E2E747970652C61297D2C746869732E7472616E736974696F6E2E737570706F727465643F28746869732E6269';
wwv_flow_api.g_varchar2_table(49) := '6E64286B2C746869732E7472616E736974696F6E2E747970652C61292C6B2E636C6173734E616D653D22616C65727469667920616C6572746966792D6869646520616C6572746966792D68696464656E22293A6B2E636C6173734E616D653D22616C6572';
wwv_flow_api.g_varchar2_table(50) := '7469667920616C6572746966792D6869646520616C6572746966792D68696464656E20616C6572746966792D697348696464656E222C6A2E636C6173734E616D653D22616C6572746966792D636F76657220616C6572746966792D636F7665722D686964';
wwv_flow_api.g_varchar2_table(51) := '64656E222C692E666F6375732829297D2C696E69743A66756E6374696F6E28297B642E637265617465456C656D656E7428226E617622292C642E637265617465456C656D656E74282261727469636C6522292C642E637265617465456C656D656E742822';
wwv_flow_api.g_varchar2_table(52) := '73656374696F6E22292C6A3D642E637265617465456C656D656E74282264697622292C6A2E73657441747472696275746528226964222C22616C6572746966792D636F76657222292C6A2E636C6173734E616D653D22616C6572746966792D636F766572';
wwv_flow_api.g_varchar2_table(53) := '20616C6572746966792D636F7665722D68696464656E222C642E626F64792E617070656E644368696C64286A292C6B3D642E637265617465456C656D656E74282273656374696F6E22292C6B2E73657441747472696275746528226964222C22616C6572';
wwv_flow_api.g_varchar2_table(54) := '7469667922292C6B2E636C6173734E616D653D22616C65727469667920616C6572746966792D68696464656E222C642E626F64792E617070656E644368696C64286B292C6C3D642E637265617465456C656D656E74282273656374696F6E22292C6C2E73';
wwv_flow_api.g_varchar2_table(55) := '657441747472696275746528226964222C22616C6572746966792D6C6F677322292C6C2E636C6173734E616D653D22616C6572746966792D6C6F677320616C6572746966792D6C6F67732D68696464656E222C642E626F64792E617070656E644368696C';
wwv_flow_api.g_varchar2_table(56) := '64286C292C642E626F64792E7365744174747269627574652822746162696E646578222C223022292C746869732E7472616E736974696F6E3D6F28292C64656C65746520746869732E696E69747D2C6C6F673A66756E6374696F6E28612C622C63297B76';
wwv_flow_api.g_varchar2_table(57) := '617220643D66756E6374696F6E28297B6C26266E756C6C213D3D6C2E7363726F6C6C546F707C7C6428297D3B72657475726E2266756E6374696F6E223D3D747970656F6620746869732E696E6974262628746869732E696E697428292C642829292C6C2E';
wwv_flow_api.g_varchar2_table(58) := '636C6173734E616D653D22616C6572746966792D6C6F6773222C746869732E6E6F7469667928612C622C63292C746869737D2C6E6F746966793A66756E6374696F6E28612C622C63297B76617220653D642E637265617465456C656D656E742822617274';
wwv_flow_api.g_varchar2_table(59) := '69636C6522293B652E636C6173734E616D653D22616C6572746966792D6C6F67222B2822737472696E67223D3D747970656F66206226262222213D3D623F2220616C6572746966792D6C6F672D222B623A2222292C652E696E6E657248544D4C3D612C6C';
wwv_flow_api.g_varchar2_table(60) := '2E617070656E644368696C642865292C73657454696D656F75742866756E6374696F6E28297B652E636C6173734E616D653D652E636C6173734E616D652B2220616C6572746966792D6C6F672D73686F77227D2C3530292C746869732E636C6F73652865';
wwv_flow_api.g_varchar2_table(61) := '2C63297D2C7365743A66756E6374696F6E2861297B76617220623B696628226F626A65637422213D747970656F66206126266120696E7374616E63656F66204172726179297468726F77206E6577204572726F72282261726773206D7573742062652061';
wwv_flow_api.g_varchar2_table(62) := '6E206F626A65637422293B666F72286220696E206129612E6861734F776E50726F7065727479286229262628746869735B625D3D615B625D297D2C736574466F6375733A66756E6374696F6E28297B6E3F286E2E666F63757328292C6E2E73656C656374';
wwv_flow_api.g_varchar2_table(63) := '2829293A682E666F63757328297D2C73657475703A66756E6374696F6E2861297B76617220642C693D745B305D2C6A3D746869733B723D21302C643D66756E6374696F6E2861297B612E73746F7050726F7061676174696F6E28292C6A2E736574466F63';
wwv_flow_api.g_varchar2_table(64) := '757328292C6A2E756E62696E64286B2C6A2E7472616E736974696F6E2E747970652C64297D2C746869732E7472616E736974696F6E2E737570706F72746564262621612626746869732E62696E64286B2C746869732E7472616E736974696F6E2E747970';
wwv_flow_api.g_varchar2_table(65) := '652C64292C6B2E696E6E657248544D4C3D746869732E6275696C642869292C673D632822616C6572746966792D7265736574466F63757322292C663D632822616C6572746966792D6F6B22297C7C622C653D632822616C6572746966792D63616E63656C';
wwv_flow_api.g_varchar2_table(66) := '22297C7C622C683D2263616E63656C223D3D3D702E627574746F6E466F6375733F653A226E6F6E65223D3D3D702E627574746F6E466F6375733F632822616C6572746966792D6E6F6E65466F63757322293A662C6E3D632822616C6572746966792D7465';
wwv_flow_api.g_varchar2_table(67) := '787422297C7C622C6D3D632822616C6572746966792D666F726D22297C7C622C22737472696E67223D3D747970656F6620692E706C616365686F6C64657226262222213D3D692E706C616365686F6C6465722626286E2E76616C75653D692E706C616365';
wwv_flow_api.g_varchar2_table(68) := '686F6C646572292C612626746869732E736574466F63757328292C746869732E6164644C697374656E65727328692E63616C6C6261636B297D2C756E62696E643A66756E6374696F6E28612C622C63297B2266756E6374696F6E223D3D747970656F6620';
wwv_flow_api.g_varchar2_table(69) := '612E72656D6F76654576656E744C697374656E65723F612E72656D6F76654576656E744C697374656E657228622C632C2131293A612E6465746163684576656E742626612E6465746163684576656E7428226F6E222B622C63297D7D2C7B616C6572743A';
wwv_flow_api.g_varchar2_table(70) := '66756E6374696F6E28612C622C63297B72657475726E20702E6469616C6F6728612C22616C657274222C622C22222C63292C746869737D2C636F6E6669726D3A66756E6374696F6E28612C622C63297B72657475726E20702E6469616C6F6728612C2263';
wwv_flow_api.g_varchar2_table(71) := '6F6E6669726D222C622C22222C63292C746869737D2C657874656E643A702E657874656E642C696E69743A702E696E69742C6C6F673A66756E6374696F6E28612C622C63297B72657475726E20702E6C6F6728612C622C63292C746869737D2C70726F6D';
wwv_flow_api.g_varchar2_table(72) := '70743A66756E6374696F6E28612C622C632C64297B72657475726E20702E6469616C6F6728612C2270726F6D7074222C622C632C64292C746869737D2C737563636573733A66756E6374696F6E28612C62297B72657475726E20702E6C6F6728612C2273';
wwv_flow_api.g_varchar2_table(73) := '756363657373222C62292C746869737D2C6572726F723A66756E6374696F6E28612C62297B72657475726E20702E6C6F6728612C226572726F72222C62292C746869737D2C7365743A66756E6374696F6E2861297B702E7365742861297D2C6C6162656C';
wwv_flow_api.g_varchar2_table(74) := '733A702E6C6162656C732C64656275673A702E68616E646C654572726F72737D7D2C2266756E6374696F6E223D3D747970656F6620646566696E653F646566696E65285B5D2C66756E6374696F6E28297B72657475726E206E657720637D293A22756E64';
wwv_flow_api.g_varchar2_table(75) := '6566696E6564223D3D747970656F6620612E616C657274696679262628612E616C6572746966793D6E65772063297D2874686973293B';
null;
 
end;
/

 
begin
 
wwv_flow_api.create_plugin_file (
  p_id => 27897650318057802265 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_id => 27896279114572727507 + wwv_flow_api.g_id_offset
 ,p_file_name => 'alertify.min.js'
 ,p_mime_type => 'text/javascript'
 ,p_file_content => wwv_flow_api.g_varchar2_table
  );
null;
 
end;
/

 
begin
 
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '2F2A2A0A202A205477697474657220426F6F747374726170204C6F6F6B20616E64204665656C0A202A204261736564206F6E20687474703A2F2F747769747465722E6769746875622E636F6D2F626F6F7473747261702F0A202A2F0A2E616C6572746966';
wwv_flow_api.g_varchar2_table(2) := '792C0A2E616C6572746966792D6C6F67207B0A09666F6E742D66616D696C793A2073616E732D73657269663B0A7D0A2E616C657274696679207B0A096261636B67726F756E643A20234646463B0A09626F726465723A2031707820736F6C696420233845';
wwv_flow_api.g_varchar2_table(3) := '384538453B202F2A2062726F7773657273207468617420646F6E277420737570706F72742072676261202A2F0A09626F726465723A2031707820736F6C6964207267626128302C302C302C2E33293B0A09626F726465722D7261646975733A203670783B';
wwv_flow_api.g_varchar2_table(4) := '0A09626F782D736861646F773A20302033707820377078207267626128302C302C302C2E33293B0A092D7765626B69742D6261636B67726F756E642D636C69703A2070616464696E673B20202020202F2A2053616661726920343F204368726F6D652036';
wwv_flow_api.g_varchar2_table(5) := '3F202A2F0A092020202D6D6F7A2D6261636B67726F756E642D636C69703A2070616464696E673B20202020202F2A2046697265666F7820332E36202A2F0A0920202020202020206261636B67726F756E642D636C69703A2070616464696E672D626F783B';
wwv_flow_api.g_varchar2_table(6) := '202F2A2046697265666F7820342C2053616661726920352C204F706572612031302C2049452039202A2F0A7D0A2E616C6572746966792D6469616C6F67207B0A0970616464696E673A20303B0A7D0A092E616C6572746966792D696E6E6572207B0A0909';
wwv_flow_api.g_varchar2_table(7) := '746578742D616C69676E3A206C6566743B0A097D0A09092E616C6572746966792D6D657373616765207B0A09090970616464696E673A20313570783B0A0909096D617267696E3A20303B0A09097D0A09092E616C6572746966792D746578742D77726170';
wwv_flow_api.g_varchar2_table(8) := '706572207B0A09090970616464696E673A203020313570783B0A09097D0A0909092E616C6572746966792D74657874207B0A09090909636F6C6F723A20233535353B0A09090909626F726465722D7261646975733A203470783B0A090909097061646469';
wwv_flow_api.g_varchar2_table(9) := '6E673A203870783B0A090909096261636B67726F756E642D636F6C6F723A20234646463B0A09090909626F726465723A2031707820736F6C696420234343433B0A09090909626F782D736861646F773A20696E7365742030203170782031707820726762';
wwv_flow_api.g_varchar2_table(10) := '6128302C302C302C2E303735293B0A0909097D0A0909092E616C6572746966792D746578743A666F637573207B0A09090909626F726465722D636F6C6F723A20726762612838322C3136382C3233362C2E38293B0A090909096F75746C696E653A20303B';
wwv_flow_api.g_varchar2_table(11) := '0A09090909626F782D736861646F773A20696E73657420302031707820317078207267626128302C302C302C2E303735292C203020302038707820726762612838322C3136382C3233362C2E36293B0A0909097D0A0A09092E616C6572746966792D6275';
wwv_flow_api.g_varchar2_table(12) := '74746F6E73207B0A09090970616464696E673A2031347078203135707820313570783B0A0909096261636B67726F756E643A20234635463546353B0A090909626F726465722D746F703A2031707820736F6C696420234444443B0A090909626F72646572';
wwv_flow_api.g_varchar2_table(13) := '2D7261646975733A2030203020367078203670783B0A090909626F782D736861646F773A20696E736574203020317078203020234646463B0A090909746578742D616C69676E3A2072696768743B0A09097D0A0909092E616C6572746966792D62757474';
wwv_flow_api.g_varchar2_table(14) := '6F6E2C0A0909092E616C6572746966792D627574746F6E3A686F7665722C0A0909092E616C6572746966792D627574746F6E3A666F6375732C0A0909092E616C6572746966792D627574746F6E3A616374697665207B0A090909096D617267696E2D6C65';
wwv_flow_api.g_varchar2_table(15) := '66743A20313070783B0A09090909626F726465722D7261646975733A203470783B0A09090909666F6E742D7765696768743A206E6F726D616C3B0A0909090970616464696E673A2034707820313270783B0A09090909746578742D6465636F726174696F';
wwv_flow_api.g_varchar2_table(16) := '6E3A206E6F6E653B0A09090909626F782D736861646F773A20696E73657420302031707820302072676261283235352C203235352C203235352C202E32292C20302031707820327078207267626128302C20302C20302C202E3035293B0A090909096261';
wwv_flow_api.g_varchar2_table(17) := '636B67726F756E642D696D6167653A202D7765626B69742D6C696E6561722D6772616469656E7428746F702C2072676261283235352C3235352C3235352C2E33292C2072676261283235352C3235352C3235352C3029293B0A090909096261636B67726F';
wwv_flow_api.g_varchar2_table(18) := '756E642D696D6167653A202020202D6D6F7A2D6C696E6561722D6772616469656E7428746F702C2072676261283235352C3235352C3235352C2E33292C2072676261283235352C3235352C3235352C3029293B0A090909096261636B67726F756E642D69';
wwv_flow_api.g_varchar2_table(19) := '6D6167653A20202020202D6D732D6C696E6561722D6772616469656E7428746F702C2072676261283235352C3235352C3235352C2E33292C2072676261283235352C3235352C3235352C3029293B0A090909096261636B67726F756E642D696D6167653A';
wwv_flow_api.g_varchar2_table(20) := '2020202020202D6F2D6C696E6561722D6772616469656E7428746F702C2072676261283235352C3235352C3235352C2E33292C2072676261283235352C3235352C3235352C3029293B0A090909096261636B67726F756E642D696D6167653A2020202020';
wwv_flow_api.g_varchar2_table(21) := '202020206C696E6561722D6772616469656E7428746F702C2072676261283235352C3235352C3235352C2E33292C2072676261283235352C3235352C3235352C3029293B0A0909097D0A0909092E616C6572746966792D627574746F6E3A666F63757320';
wwv_flow_api.g_varchar2_table(22) := '7B0A090909096F75746C696E653A206E6F6E653B0A09090909626F782D736861646F773A203020302035707820233242373244353B0A0909097D0A0909092E616C6572746966792D627574746F6E3A616374697665207B0A09090909706F736974696F6E';
wwv_flow_api.g_varchar2_table(23) := '3A2072656C61746976653B0A09090909626F782D736861646F773A20696E73657420302032707820347078207267626128302C302C302C2E3135292C20302031707820327078207267626128302C302C302C2E3035293B0A0909097D0A090909092E616C';
wwv_flow_api.g_varchar2_table(24) := '6572746966792D627574746F6E2D63616E63656C2C0A090909092E616C6572746966792D627574746F6E2D63616E63656C3A686F7665722C0A090909092E616C6572746966792D627574746F6E2D63616E63656C3A666F6375732C0A090909092E616C65';
wwv_flow_api.g_varchar2_table(25) := '72746966792D627574746F6E2D63616E63656C3A616374697665207B0A0909090909746578742D736861646F773A2030202D31707820302072676261283235352C3235352C3235352C2E3735293B0A09090909096261636B67726F756E642D636F6C6F72';
wwv_flow_api.g_varchar2_table(26) := '3A20234536453645363B0A0909090909626F726465723A2031707820736F6C696420234242423B0A0909090909636F6C6F723A20233333333B0A09090909096261636B67726F756E642D696D6167653A202D7765626B69742D6C696E6561722D67726164';
wwv_flow_api.g_varchar2_table(27) := '69656E7428746F702C20234646462C2023453645364536293B0A09090909096261636B67726F756E642D696D6167653A202020202D6D6F7A2D6C696E6561722D6772616469656E7428746F702C20234646462C2023453645364536293B0A090909090962';
wwv_flow_api.g_varchar2_table(28) := '61636B67726F756E642D696D6167653A20202020202D6D732D6C696E6561722D6772616469656E7428746F702C20234646462C2023453645364536293B0A09090909096261636B67726F756E642D696D6167653A2020202020202D6F2D6C696E6561722D';
wwv_flow_api.g_varchar2_table(29) := '6772616469656E7428746F702C20234646462C2023453645364536293B0A09090909096261636B67726F756E642D696D6167653A2020202020202020206C696E6561722D6772616469656E7428746F702C20234646462C2023453645364536293B0A0909';
wwv_flow_api.g_varchar2_table(30) := '09097D0A090909092E616C6572746966792D627574746F6E2D63616E63656C3A686F7665722C0A090909092E616C6572746966792D627574746F6E2D63616E63656C3A666F6375732C0A090909092E616C6572746966792D627574746F6E2D63616E6365';
wwv_flow_api.g_varchar2_table(31) := '6C3A616374697665207B0A09090909096261636B67726F756E643A20234536453645363B0A090909097D0A090909092E616C6572746966792D627574746F6E2D6F6B2C0A090909092E616C6572746966792D627574746F6E2D6F6B3A686F7665722C0A09';
wwv_flow_api.g_varchar2_table(32) := '0909092E616C6572746966792D627574746F6E2D6F6B3A666F6375732C0A090909092E616C6572746966792D627574746F6E2D6F6B3A616374697665207B0A0909090909746578742D736861646F773A2030202D3170782030207267626128302C302C30';
wwv_flow_api.g_varchar2_table(33) := '2C2E3235293B0A09090909096261636B67726F756E642D636F6C6F723A20233034433B0A0909090909626F726465723A2031707820736F6C696420233034433B0A0909090909626F726465722D636F6C6F723A2023303443202330344320233030324138';
wwv_flow_api.g_varchar2_table(34) := '303B0A0909090909626F726465722D636F6C6F723A207267626128302C20302C20302C20302E3129207267626128302C20302C20302C20302E3129207267626128302C20302C20302C20302E3235293B0A0909090909636F6C6F723A20234646463B0A09';
wwv_flow_api.g_varchar2_table(35) := '0909097D0A090909092E616C6572746966792D627574746F6E2D6F6B3A686F7665722C0A090909092E616C6572746966792D627574746F6E2D6F6B3A666F6375732C0A090909092E616C6572746966792D627574746F6E2D6F6B3A616374697665207B0A';
wwv_flow_api.g_varchar2_table(36) := '09090909096261636B67726F756E643A20233034433B0A090909097D0A0A2E616C6572746966792D6C6F67207B0A096261636B67726F756E643A20234439454446373B0A0970616464696E673A2038707820313470783B0A09626F726465722D72616469';
wwv_flow_api.g_varchar2_table(37) := '75733A203470783B0A09636F6C6F723A20233341384142463B0A09746578742D736861646F773A20302031707820302072676261283235352C3235352C3235352C2E35293B0A09626F726465723A2031707820736F6C696420234243453846313B0A7D0A';
wwv_flow_api.g_varchar2_table(38) := '092E616C6572746966792D6C6F672D6572726F72207B0A0909636F6C6F723A20234239344134383B0A09096261636B67726F756E643A20234632444544453B0A0909626F726465723A2031707820736F6C696420234545443344373B0A097D0A092E616C';
wwv_flow_api.g_varchar2_table(39) := '6572746966792D6C6F672D73756363657373207B0A0909636F6C6F723A20233436383834373B0A09096261636B67726F756E643A20234446463044383B0A0909626F726465723A2031707820736F6C696420234436453943363B0A097D';
null;
 
end;
/

 
begin
 
wwv_flow_api.create_plugin_file (
  p_id => 27897654726785869864 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_id => 27896279114572727507 + wwv_flow_api.g_id_offset
 ,p_file_name => 'alertify.bootstrap.css'
 ,p_mime_type => 'text/css'
 ,p_file_content => wwv_flow_api.g_varchar2_table
  );
null;
 
end;
/

 
begin
 
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '2F2A2A0A202A2044656661756C74204C6F6F6B20616E64204665656C0A202A2F0A2E616C6572746966792C0A2E616C6572746966792D6C6F67207B0A09666F6E742D66616D696C793A2073616E732D73657269663B0A7D0A2E616C657274696679207B0A';
wwv_flow_api.g_varchar2_table(2) := '096261636B67726F756E643A20234646463B0A09626F726465723A203130707820736F6C696420233333333B202F2A2062726F7773657273207468617420646F6E277420737570706F72742072676261202A2F0A09626F726465723A203130707820736F';
wwv_flow_api.g_varchar2_table(3) := '6C6964207267626128302C302C302C2E37293B0A09626F726465722D7261646975733A203870783B0A09626F782D736861646F773A20302033707820337078207267626128302C302C302C2E33293B0A092D7765626B69742D6261636B67726F756E642D';
wwv_flow_api.g_varchar2_table(4) := '636C69703A2070616464696E673B20202020202F2A2053616661726920343F204368726F6D6520363F202A2F0A092020202D6D6F7A2D6261636B67726F756E642D636C69703A2070616464696E673B20202020202F2A2046697265666F7820332E36202A';
wwv_flow_api.g_varchar2_table(5) := '2F0A0920202020202020206261636B67726F756E642D636C69703A2070616464696E672D626F783B202F2A2046697265666F7820342C2053616661726920352C204F706572612031302C2049452039202A2F0A7D0A092E616C6572746966792D74657874';
wwv_flow_api.g_varchar2_table(6) := '207B0A0909626F726465723A2031707820736F6C696420234343433B0A090970616464696E673A20313070783B0A0909626F726465722D7261646975733A203470783B0A097D0A092E616C6572746966792D627574746F6E207B0A0909626F726465722D';
wwv_flow_api.g_varchar2_table(7) := '7261646975733A203470783B0A0909636F6C6F723A20234646463B0A0909666F6E742D7765696768743A20626F6C643B0A090970616464696E673A2036707820313570783B0A0909746578742D6465636F726174696F6E3A206E6F6E653B0A0909746578';
wwv_flow_api.g_varchar2_table(8) := '742D736861646F773A20317078203170782030207267626128302C302C302C2E35293B0A0909626F782D736861646F773A20696E736574203020317078203020302072676261283235352C3235352C3235352C2E35293B0A09096261636B67726F756E64';
wwv_flow_api.g_varchar2_table(9) := '2D696D6167653A202D7765626B69742D6C696E6561722D6772616469656E7428746F702C2072676261283235352C3235352C3235352C2E33292C2072676261283235352C3235352C3235352C3029293B0A09096261636B67726F756E642D696D6167653A';
wwv_flow_api.g_varchar2_table(10) := '202020202D6D6F7A2D6C696E6561722D6772616469656E7428746F702C2072676261283235352C3235352C3235352C2E33292C2072676261283235352C3235352C3235352C3029293B0A09096261636B67726F756E642D696D6167653A20202020202D6D';
wwv_flow_api.g_varchar2_table(11) := '732D6C696E6561722D6772616469656E7428746F702C2072676261283235352C3235352C3235352C2E33292C2072676261283235352C3235352C3235352C3029293B0A09096261636B67726F756E642D696D6167653A2020202020202D6F2D6C696E6561';
wwv_flow_api.g_varchar2_table(12) := '722D6772616469656E7428746F702C2072676261283235352C3235352C3235352C2E33292C2072676261283235352C3235352C3235352C3029293B0A09096261636B67726F756E642D696D6167653A2020202020202020206C696E6561722D6772616469';
wwv_flow_api.g_varchar2_table(13) := '656E7428746F702C2072676261283235352C3235352C3235352C2E33292C2072676261283235352C3235352C3235352C3029293B0A097D0A092E616C6572746966792D627574746F6E3A686F7665722C0A092E616C6572746966792D627574746F6E3A66';
wwv_flow_api.g_varchar2_table(14) := '6F637573207B0A09096F75746C696E653A206E6F6E653B0A09096261636B67726F756E642D696D6167653A202D7765626B69742D6C696E6561722D6772616469656E7428746F702C207267626128302C302C302C2E31292C207267626128302C302C302C';
wwv_flow_api.g_varchar2_table(15) := '3029293B0A09096261636B67726F756E642D696D6167653A202020202D6D6F7A2D6C696E6561722D6772616469656E7428746F702C207267626128302C302C302C2E31292C207267626128302C302C302C3029293B0A09096261636B67726F756E642D69';
wwv_flow_api.g_varchar2_table(16) := '6D6167653A20202020202D6D732D6C696E6561722D6772616469656E7428746F702C207267626128302C302C302C2E31292C207267626128302C302C302C3029293B0A09096261636B67726F756E642D696D6167653A2020202020202D6F2D6C696E6561';
wwv_flow_api.g_varchar2_table(17) := '722D6772616469656E7428746F702C207267626128302C302C302C2E31292C207267626128302C302C302C3029293B0A09096261636B67726F756E642D696D6167653A2020202020202020206C696E6561722D6772616469656E7428746F702C20726762';
wwv_flow_api.g_varchar2_table(18) := '6128302C302C302C2E31292C207267626128302C302C302C3029293B0A097D0A092E616C6572746966792D627574746F6E3A666F637573207B0A0909626F782D736861646F773A20302030203135707820233242373244353B0A097D0A092E616C657274';
wwv_flow_api.g_varchar2_table(19) := '6966792D627574746F6E3A616374697665207B0A0909706F736974696F6E3A2072656C61746976653B0A0909626F782D736861646F773A20696E73657420302032707820347078207267626128302C302C302C2E3135292C203020317078203270782072';
wwv_flow_api.g_varchar2_table(20) := '67626128302C302C302C2E3035293B0A097D0A09092E616C6572746966792D627574746F6E2D63616E63656C2C0A09092E616C6572746966792D627574746F6E2D63616E63656C3A686F7665722C0A09092E616C6572746966792D627574746F6E2D6361';
wwv_flow_api.g_varchar2_table(21) := '6E63656C3A666F637573207B0A0909096261636B67726F756E642D636F6C6F723A20234645314130303B0A090909626F726465723A2031707820736F6C696420234438333532363B0A09097D0A09092E616C6572746966792D627574746F6E2D6F6B2C0A';
wwv_flow_api.g_varchar2_table(22) := '09092E616C6572746966792D627574746F6E2D6F6B3A686F7665722C0A09092E616C6572746966792D627574746F6E2D6F6B3A666F637573207B0A0909096261636B67726F756E642D636F6C6F723A20233543423831313B0A090909626F726465723A20';
wwv_flow_api.g_varchar2_table(23) := '31707820736F6C696420233342373830383B0A09097D0A0A2E616C6572746966792D6C6F67207B0A096261636B67726F756E643A20233146314631463B0A096261636B67726F756E643A207267626128302C302C302C2E39293B0A0970616464696E673A';
wwv_flow_api.g_varchar2_table(24) := '20313570783B0A09626F726465722D7261646975733A203470783B0A09636F6C6F723A20234646463B0A09746578742D736861646F773A202D317078202D3170782030207267626128302C302C302C2E35293B0A7D0A092E616C6572746966792D6C6F67';
wwv_flow_api.g_varchar2_table(25) := '2D6572726F72207B0A09096261636B67726F756E643A20234645314130303B0A09096261636B67726F756E643A2072676261283235342C32362C302C2E39293B0A097D0A092E616C6572746966792D6C6F672D73756363657373207B0A09096261636B67';
wwv_flow_api.g_varchar2_table(26) := '726F756E643A20233543423831313B0A09096261636B67726F756E643A20726762612839322C3138342C31372C2E39293B0A097D';
null;
 
end;
/

 
begin
 
wwv_flow_api.create_plugin_file (
  p_id => 27897657516783804044 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_id => 27896279114572727507 + wwv_flow_api.g_id_offset
 ,p_file_name => 'alertify.default.css'
 ,p_mime_type => 'text/css'
 ,p_file_content => wwv_flow_api.g_varchar2_table
  );
null;
 
end;
/

 
begin
 
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '2E616C6572746966792C0A2E616C6572746966792D73686F772C0A2E616C6572746966792D6C6F67207B0A092D7765626B69742D7472616E736974696F6E3A20616C6C203530306D732063756269632D62657A69657228302E3137352C20302E3838352C';
wwv_flow_api.g_varchar2_table(2) := '20302E3332302C20312E323735293B0A092020202D6D6F7A2D7472616E736974696F6E3A20616C6C203530306D732063756269632D62657A69657228302E3137352C20302E3838352C20302E3332302C20312E323735293B0A09202020202D6D732D7472';
wwv_flow_api.g_varchar2_table(3) := '616E736974696F6E3A20616C6C203530306D732063756269632D62657A69657228302E3137352C20302E3838352C20302E3332302C20312E323735293B0A0920202020202D6F2D7472616E736974696F6E3A20616C6C203530306D732063756269632D62';
wwv_flow_api.g_varchar2_table(4) := '657A69657228302E3137352C20302E3838352C20302E3332302C20312E323735293B0A0920202020202020207472616E736974696F6E3A20616C6C203530306D732063756269632D62657A69657228302E3137352C20302E3838352C20302E3332302C20';
wwv_flow_api.g_varchar2_table(5) := '312E323735293B202F2A20656173654F75744261636B202A2F0A7D0A2E616C6572746966792D68696465207B0A092D7765626B69742D7472616E736974696F6E3A20616C6C203235306D732063756269632D62657A69657228302E3630302C202D302E32';
wwv_flow_api.g_varchar2_table(6) := '38302C20302E3733352C20302E303435293B0A092020202D6D6F7A2D7472616E736974696F6E3A20616C6C203235306D732063756269632D62657A69657228302E3630302C202D302E3238302C20302E3733352C20302E303435293B0A09202020202D6D';
wwv_flow_api.g_varchar2_table(7) := '732D7472616E736974696F6E3A20616C6C203235306D732063756269632D62657A69657228302E3630302C202D302E3238302C20302E3733352C20302E303435293B0A0920202020202D6F2D7472616E736974696F6E3A20616C6C203235306D73206375';
wwv_flow_api.g_varchar2_table(8) := '6269632D62657A69657228302E3630302C202D302E3238302C20302E3733352C20302E303435293B0A0920202020202020207472616E736974696F6E3A20616C6C203235306D732063756269632D62657A69657228302E3630302C202D302E3238302C20';
wwv_flow_api.g_varchar2_table(9) := '302E3733352C20302E303435293B202F2A2065617365496E4261636B202A2F0A7D0A2E616C6572746966792D6C6F672D68696465207B0A092D7765626B69742D7472616E736974696F6E3A20616C6C203530306D732063756269632D62657A6965722830';
wwv_flow_api.g_varchar2_table(10) := '2E3630302C202D302E3238302C20302E3733352C20302E303435293B0A092020202D6D6F7A2D7472616E736974696F6E3A20616C6C203530306D732063756269632D62657A69657228302E3630302C202D302E3238302C20302E3733352C20302E303435';
wwv_flow_api.g_varchar2_table(11) := '293B0A09202020202D6D732D7472616E736974696F6E3A20616C6C203530306D732063756269632D62657A69657228302E3630302C202D302E3238302C20302E3733352C20302E303435293B0A0920202020202D6F2D7472616E736974696F6E3A20616C';
wwv_flow_api.g_varchar2_table(12) := '6C203530306D732063756269632D62657A69657228302E3630302C202D302E3238302C20302E3733352C20302E303435293B0A0920202020202020207472616E736974696F6E3A20616C6C203530306D732063756269632D62657A69657228302E363030';
wwv_flow_api.g_varchar2_table(13) := '2C202D302E3238302C20302E3733352C20302E303435293B202F2A2065617365496E4261636B202A2F0A7D0A2E616C6572746966792D636F766572207B0A09706F736974696F6E3A2066697865643B207A2D696E6465783A2039393939393B0A09746F70';
wwv_flow_api.g_varchar2_table(14) := '3A20303B2072696768743A20303B20626F74746F6D3A20303B206C6566743A20303B0A096261636B67726F756E642D636F6C6F723A77686974653B0A0966696C7465723A616C706861286F7061636974793D30293B0A096F7061636974793A303B0A7D0A';
wwv_flow_api.g_varchar2_table(15) := '092E616C6572746966792D636F7665722D68696464656E207B0A0909646973706C61793A206E6F6E653B0A097D0A2E616C657274696679207B0A09706F736974696F6E3A2066697865643B207A2D696E6465783A2039393939393B0A09746F703A203530';
wwv_flow_api.g_varchar2_table(16) := '70783B206C6566743A203530253B0A0977696474683A2035353070783B0A096D617267696E2D6C6566743A202D32373570783B0A096F7061636974793A20313B0A7D0A092E616C6572746966792D68696464656E207B0A09092D7765626B69742D747261';
wwv_flow_api.g_varchar2_table(17) := '6E73666F726D3A207472616E736C61746528302C2D3135307078293B0A09092020202D6D6F7A2D7472616E73666F726D3A207472616E736C61746528302C2D3135307078293B0A0909202020202D6D732D7472616E73666F726D3A207472616E736C6174';
wwv_flow_api.g_varchar2_table(18) := '6528302C2D3135307078293B0A090920202020202D6F2D7472616E73666F726D3A207472616E736C61746528302C2D3135307078293B0A090920202020202020207472616E73666F726D3A207472616E736C61746528302C2D3135307078293B0A09096F';
wwv_flow_api.g_varchar2_table(19) := '7061636974793A20303B0A0909646973706C61793A206E6F6E653B0A097D0A092F2A206F766572777269746520646973706C61793A206E6F6E653B20666F722065766572797468696E6720657863657074204945362D38202A2F0A093A726F6F74202A3E';
wwv_flow_api.g_varchar2_table(20) := '202E616C6572746966792D68696464656E207B0A0909646973706C61793A20626C6F636B3B0A09097669736962696C6974793A2068696464656E3B0A097D0A2E616C6572746966792D6C6F6773207B0A09706F736974696F6E3A2066697865643B0A097A';
wwv_flow_api.g_varchar2_table(21) := '2D696E6465783A20353030303B0A09626F74746F6D3A20313070783B0A0972696768743A20313070783B0A0977696474683A2033303070783B0A7D0A2E616C6572746966792D6C6F67732D68696464656E207B0A09646973706C61793A206E6F6E653B0A';
wwv_flow_api.g_varchar2_table(22) := '7D0A092E616C6572746966792D6C6F67207B0A0909646973706C61793A20626C6F636B3B0A09096D617267696E2D746F703A20313070783B0A0909706F736974696F6E3A2072656C61746976653B0A090972696768743A202D33303070783B0A09096F70';
wwv_flow_api.g_varchar2_table(23) := '61636974793A20303B0A097D0A092E616C6572746966792D6C6F672D73686F77207B0A090972696768743A20303B0A09096F7061636974793A20313B0A097D0A092E616C6572746966792D6C6F672D68696465207B0A09092D7765626B69742D7472616E';
wwv_flow_api.g_varchar2_table(24) := '73666F726D3A207472616E736C6174652833303070782C2030293B0A09092020202D6D6F7A2D7472616E73666F726D3A207472616E736C6174652833303070782C2030293B0A0909202020202D6D732D7472616E73666F726D3A207472616E736C617465';
wwv_flow_api.g_varchar2_table(25) := '2833303070782C2030293B0A090920202020202D6F2D7472616E73666F726D3A207472616E736C6174652833303070782C2030293B0A090920202020202020207472616E73666F726D3A207472616E736C6174652833303070782C2030293B0A09096F70';
wwv_flow_api.g_varchar2_table(26) := '61636974793A20303B0A097D0A092E616C6572746966792D6469616C6F67207B0A090970616464696E673A20323570783B0A097D0A09092E616C6572746966792D7265736574466F637573207B0A090909626F726465723A20303B0A090909636C69703A';
wwv_flow_api.g_varchar2_table(27) := '20726563742830203020302030293B0A0909096865696768743A203170783B0A0909096D617267696E3A202D3170783B0A0909096F766572666C6F773A2068696464656E3B0A09090970616464696E673A20303B0A090909706F736974696F6E3A206162';
wwv_flow_api.g_varchar2_table(28) := '736F6C7574653B0A09090977696474683A203170783B0A09097D0A09092E616C6572746966792D696E6E6572207B0A090909746578742D616C69676E3A2063656E7465723B0A09097D0A09092E616C6572746966792D74657874207B0A0909096D617267';
wwv_flow_api.g_varchar2_table(29) := '696E2D626F74746F6D3A20313570783B0A09090977696474683A20313030253B0A0909092D7765626B69742D626F782D73697A696E673A20626F726465722D626F783B0A0909092020202D6D6F7A2D626F782D73697A696E673A20626F726465722D626F';
wwv_flow_api.g_varchar2_table(30) := '783B0A0909092020202020202020626F782D73697A696E673A20626F726465722D626F783B0A090909666F6E742D73697A653A20313030253B0A09097D0A09092E616C6572746966792D627574746F6E73207B0A09097D0A0909092E616C657274696679';
wwv_flow_api.g_varchar2_table(31) := '2D627574746F6E2C0A0909092E616C6572746966792D627574746F6E3A686F7665722C0A0909092E616C6572746966792D627574746F6E3A6163746976652C0A0909092E616C6572746966792D627574746F6E3A76697369746564207B0A090909096261';
wwv_flow_api.g_varchar2_table(32) := '636B67726F756E643A206E6F6E653B0A09090909746578742D6465636F726174696F6E3A206E6F6E653B0A09090909626F726465723A206E6F6E653B0A090909092F2A206C696E652D68656967687420616E6420666F6E742D73697A6520666F7220696E';
wwv_flow_api.g_varchar2_table(33) := '70757420627574746F6E202A2F0A090909096C696E652D6865696768743A20312E353B0A09090909666F6E742D73697A653A20313030253B0A09090909646973706C61793A20696E6C696E652D626C6F636B3B0A09090909637572736F723A20706F696E';
wwv_flow_api.g_varchar2_table(34) := '7465723B0A090909096D617267696E2D6C6566743A203570783B0A0909097D0A0A2E616C6572746966792D697348696464656E207B0A09646973706C61793A206E6F6E653B0A7D0A0A23616C6572746966792D666F726D207B0A20206D617267696E3A20';
wwv_flow_api.g_varchar2_table(35) := '303B0A7D0A0A406D65646961206F6E6C792073637265656E20616E6420286D61782D77696474683A20363830707829207B0A092E616C6572746966792C0A092E616C6572746966792D6C6F6773207B0A090977696474683A203930253B0A09092D776562';
wwv_flow_api.g_varchar2_table(36) := '6B69742D626F782D73697A696E673A20626F726465722D626F783B0A09092020202D6D6F7A2D626F782D73697A696E673A20626F726465722D626F783B0A09092020202020202020626F782D73697A696E673A20626F726465722D626F783B0A097D0A09';
wwv_flow_api.g_varchar2_table(37) := '2E616C657274696679207B0A09096C6566743A2035253B0A09096D617267696E3A20303B0A097D0A7D0A';
null;
 
end;
/

 
begin
 
wwv_flow_api.create_plugin_file (
  p_id => 27959372214835163180 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_id => 27896279114572727507 + wwv_flow_api.g_id_offset
 ,p_file_name => 'alertify.core.css'
 ,p_mime_type => 'text/css'
 ,p_file_content => wwv_flow_api.g_varchar2_table
  );
null;
 
end;
/

 
begin
 
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '766172206265437462416C657274696679203D207B7D3B0D0A0D0A6265437462416C6572746966792E7574696C203D207B0D0A20207265706C6163654974656D733A2066756E6374696F6E2028704D736729207B0D0A20202020766172206974656D3B0D';
wwv_flow_api.g_varchar2_table(2) := '0A20202020766172206974656D4F6E506167653B0D0A20202020766172206974656D73203D206E6577205265674578702822235C5C772B23222C20226722293B0D0A20202020766172207265706C616365644D7367203D20704D73673B0D0A0D0A202020';
wwv_flow_api.g_varchar2_table(3) := '207768696C6520286974656D203D206974656D732E6578656328704D73672929207B0D0A20202020202020206974656D4F6E50616765203D202478286974656D5B305D2E7265706C616365282F232F672C20222229293B0D0A2020202020202020696620';
wwv_flow_api.g_varchar2_table(4) := '286974656D4F6E5061676529207B0D0A2020202020202020202020207265706C616365644D7367203D207265706C616365644D73672E7265706C616365286974656D5B305D2C202476286974656D4F6E5061676529293B0D0A20202020202020207D0D0A';
wwv_flow_api.g_varchar2_table(5) := '202020207D0D0A2020202072657475726E207265706C616365644D73673B0D0A20207D0D0A7D3B0D0A0D0A6265437462416C6572746966792E6469616C6F67203D207B0D0A20207574696C3A206265437462416C6572746966792E7574696C2C0D0A0D0A';
wwv_flow_api.g_varchar2_table(6) := '2020616C6572743A2066756E6374696F6E2028705468697329207B0D0A20202020616C6572746966792E616C65727428746869732E7574696C2E7265706C6163654974656D732870546869732E616374696F6E2E6174747269627574653034292C206675';
wwv_flow_api.g_varchar2_table(7) := '6E6374696F6E20286529207B0D0A202020202020617065782E64612E726573756D652870546869732E726573756D6543616C6C6261636B2C2066616C7365293B0D0A202020207D293B0D0A20207D2C0D0A2020636F6E6669726D3A2066756E6374696F6E';
wwv_flow_api.g_varchar2_table(8) := '2028705468697329207B0D0A20202020616C6572746966792E636F6E6669726D28746869732E7574696C2E7265706C6163654974656D732870546869732E616374696F6E2E6174747269627574653034292C2066756E6374696F6E20286529207B0D0A20';
wwv_flow_api.g_varchar2_table(9) := '2020202020696620286529207B0D0A20202020202020206966202870546869732E616374696F6E2E77616974466F72526573756C7429207B0D0A20202020202020202020617065782E64612E726573756D652870546869732E726573756D6543616C6C62';
wwv_flow_api.g_varchar2_table(10) := '61636B2C2066616C7365293B0D0A20202020202020207D0D0A2020202020207D20656C7365207B0D0A20202020202020203B0D0A2020202020207D0D0A202020207D293B0D0A20207D2C0D0A202070726F6D70743A2066756E6374696F6E202870546869';
wwv_flow_api.g_varchar2_table(11) := '7329207B0D0A20202020616C6572746966792E70726F6D707428746869732E7574696C2E7265706C6163654974656D732870546869732E616374696F6E2E6174747269627574653034292C2066756E6374696F6E2028652C2073747229207B0D0A202020';
wwv_flow_api.g_varchar2_table(12) := '202020696620286529207B0D0A20202020202020206966202870546869732E616374696F6E2E77616974466F72526573756C7429207B0D0A2020202020202020202024732870546869732E616374696F6E2E61747472696275746530362C20737472293B';
wwv_flow_api.g_varchar2_table(13) := '0D0A20202020202020202020617065782E64612E726573756D652870546869732E726573756D6543616C6C6261636B2C2066616C7365293B0D0A20202020202020207D0D0A2020202020207D20656C7365207B0D0A20202020202020203B0D0A20202020';
wwv_flow_api.g_varchar2_table(14) := '20207D0D0A202020207D2C20746869732E7574696C2E7265706C6163654974656D732870546869732E616374696F6E2E617474726962757465303529293B0D0A20207D0D0A7D3B0D0A0D0A6265437462416C6572746966792E6E6F74696669636174696F';
wwv_flow_api.g_varchar2_table(15) := '6E203D207B0D0A20207574696C3A206265437462416C6572746966792E7574696C2C0D0A0D0A20206C6F673A2066756E6374696F6E2028705468697329207B0D0A20202020616C6572746966792E6C6F6728746869732E7574696C2E7265706C61636549';
wwv_flow_api.g_varchar2_table(16) := '74656D732870546869732E616374696F6E2E6174747269627574653034292C2070546869732E616374696F6E2E61747472696275746530332E746F4C6F7765724361736528292C204E756D6265722870546869732E616374696F6E2E6174747269627574';
wwv_flow_api.g_varchar2_table(17) := '65313129293B0D0A20202020617065782E64612E726573756D652870546869732E726573756D6543616C6C6261636B2C2066616C7365293B0D0A20207D0D0A7D3B';
null;
 
end;
/

 
begin
 
wwv_flow_api.create_plugin_file (
  p_id => 27966138409043927240 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_id => 27896279114572727507 + wwv_flow_api.g_id_offset
 ,p_file_name => 'apex.alertify.js'
 ,p_mime_type => 'text/javascript'
 ,p_file_content => wwv_flow_api.g_varchar2_table
  );
null;
 
end;
/

commit;
begin
execute immediate 'begin sys.dbms_session.set_nls( param => ''NLS_NUMERIC_CHARACTERS'', value => '''''''' || replace(wwv_flow_api.g_nls_numeric_chars,'''''''','''''''''''') || ''''''''); end;';
end;
/
set verify on
set feedback on
set define on
prompt  ...done
