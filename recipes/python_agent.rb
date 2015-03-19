agent = node['appdynamics']['python_agent']
controller = node['appdynamics']['controller']
http_proxy = node['appdynamics']['http_proxy']

python_pip 'appdynamics' do
  virtualenv agent['virtualenv'] if agent['virtualenv']
  action agent['action']
  version agent['version'] if agent['version'] != 'latest'
  options '--pre' if agent['prerelease']
end

template agent['config_file'] do
  cookbook agent['template']['cookbook']
  source agent['template']['source']
  owner agent['template']['user']
  group agent['template']['group']
  mode agent['template']['mode']

  variables(
    :app_name => node['appdynamics']['app_name'],
    :tier_name => node['appdynamics']['tier_name'],
    :node_name => node['appdynamics']['node_name'],

    :controller_host => controller['host'],
    :controller_port => controller['port'],
    :controller_ssl => controller['ssl'],
    :controller_user => controller['user'],
    :controller_accesskey => controller['accesskey'],

    :http_proxy_host => controller['http_proxy']['host'],
    :http_proxy_port => controller['http_proxy']['port'],
    :http_proxy_user => controller['http_proxy']['user'],
    :http_proxy_password_file => controller['http_proxy']['password_file'],

    :debug => agent['debug'],
    :dir => agent['dir']
  )
end
