function render(p_dynamic_action in apex_plugin.t_dynamic_action
              , p_plugin         in apex_plugin.t_plugin)
return apex_plugin.t_dynamic_action_render_result is
  l_render_result apex_plugin.t_dynamic_action_render_result;
begin
  apex_javascript.add_library(
    p_name      => 'alertify.min',
    p_directory => p_plugin.file_prefix,
    p_version   => null
  );
  apex_css.add_file(
    p_name      => 'alertify.core',
    p_directory => p_plugin.file_prefix,
    p_version   => null
  );
  apex_css.add_file(
    p_name      => 'alertify.default',
    p_directory => p_plugin.file_prefix,
    p_version   => null
  );

  l_render_result.javascript_function := '
    function() {
      console.log(this);
      var l_resumeCallback = this.resumeCallback;
      var l_waitForResult = this.action.waitForResult;

      alertify.confirm("My first confirm message in APEX!", function (e) {
          if (e) {
              console.log("he clicked okay");
              if (l_waitForResult) {
                console.log("calling apex.da.resume()");
                apex.da.resume(l_resumeCallback, false);
              }
          } else {
              console.log("he clicked cancel");
              console.log("skipping proceeding actions :x");
          }
      });
    }
  ';

  return l_render_result;
end render;