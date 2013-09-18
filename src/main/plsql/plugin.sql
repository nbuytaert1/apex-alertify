function render(p_dynamic_action in apex_plugin.t_dynamic_action
              , p_plugin         in apex_plugin.t_plugin)
return apex_plugin.t_dynamic_action_render_result is
  l_theme                varchar2(4000) := p_plugin.attribute_01;
  l_def_ok_btn_label     varchar2(4000) := p_plugin.attribute_02;
  l_def_cancel_btn_label varchar2(4000) := p_plugin.attribute_03;

  l_message_type       varchar2(4000) := p_dynamic_action.attribute_01;
  l_dialog_type        varchar2(4000) := p_dynamic_action.attribute_02;
  l_notification_type  varchar2(4000) := p_dynamic_action.attribute_03;
  l_message            varchar2(4000) := p_dynamic_action.attribute_04;
  l_default_value      varchar2(4000) := p_dynamic_action.attribute_05;
  l_return_into_item   varchar2(4000) := p_dynamic_action.attribute_06;
  l_ok_btn_label       varchar2(4000) := p_dynamic_action.attribute_07;
  l_cancel_btn_label   varchar2(4000) := p_dynamic_action.attribute_08;
  l_btn_order          varchar2(4000) := p_dynamic_action.attribute_09;
  l_btn_focus          varchar2(4000) := p_dynamic_action.attribute_10;
  l_notification_delay varchar2(4000) := p_dynamic_action.attribute_11;

  l_function_call varchar2(4000);
  l_render_result apex_plugin.t_dynamic_action_render_result;


  function get_properties
  return varchar2 is
    l_ok_label     varchar2(4000);
    l_cancel_label varchar2(4000);
    l_props        varchar2(32767);
  begin
    l_ok_label := nvl(l_ok_btn_label, nvl(l_def_ok_btn_label, 'OK'));
    l_cancel_label := nvl(l_cancel_btn_label, nvl(l_def_cancel_btn_label, 'Cancel'));

    l_props := 'alertify.set({labels:{ok:"' || l_ok_label || '",cancel:"' || l_cancel_label || '"},';

    if (l_dialog_type = 'ALERT') then
      l_props := l_props || 'buttonReverse:false,buttonFocus:"ok"';
    else
      if (l_btn_order = 'REVERSE') then
        l_props := l_props || 'buttonReverse:true,';
      else
        l_props := l_props || 'buttonReverse:false,';
      end if;

      if (l_btn_focus = 'OK') then
        l_props := l_props || 'buttonFocus:"ok"';
      elsif (l_btn_focus = 'CANCEL') then
        l_props := l_props || 'buttonFocus:"cancel"';
      else
        l_props := l_props || 'buttonFocus:"none"';
      end if;
    end if;

    l_props := l_props || '});';

    return l_props;
  end get_properties;
begin
  if (apex_application.g_debug) then
    apex_plugin_util.debug_dynamic_action(p_plugin, p_dynamic_action);
  end if;

  apex_javascript.add_library(
    p_name      => 'alertify.min',
    p_directory => p_plugin.file_prefix,
    p_version   => null
  );
  apex_javascript.add_library(
    p_name      => 'apex.alertify',
    p_directory => p_plugin.file_prefix,
    p_version   => null
  );
  apex_css.add_file(
    p_name      => 'alertify.core',
    p_directory => p_plugin.file_prefix,
    p_version   => null
  );
  if (l_theme = 'DEFAULT') then
    apex_css.add_file(
      p_name      => 'alertify.default',
      p_directory => p_plugin.file_prefix,
      p_version   => null
    );
  else
    apex_css.add_file(
      p_name      => 'alertify.bootstrap',
      p_directory => p_plugin.file_prefix,
      p_version   => null
    );
  end if;

  l_render_result.attribute_03 := l_notification_type;
  l_render_result.attribute_04 := l_message;
  l_render_result.attribute_05 := l_default_value;
  l_render_result.attribute_06 := l_return_into_item;
  l_render_result.attribute_11 := nvl(l_notification_delay, 5000);

  if (l_message_type = 'DIALOG') then
    if (l_dialog_type = 'ALERT') then
      l_function_call := 'beCtbAlertify.dialog.alert(this);';
    elsif (l_dialog_type = 'CONFIRM') then
      l_function_call := 'beCtbAlertify.dialog.confirm(this);';
    else
      l_function_call := 'beCtbAlertify.dialog.prompt(this);';
    end if;
    l_render_result.javascript_function := 'function() {' || get_properties || ' ' || l_function_call || '}';
  else
    l_function_call := 'beCtbAlertify.notification.log(this);';
    l_render_result.javascript_function := 'function() {' || l_function_call || '}';
  end if;

  return l_render_result;
end render;