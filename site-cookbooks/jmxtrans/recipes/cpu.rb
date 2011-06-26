include_recipe "jmxtrans"

jmxtrans_query "heap" do
  options :obj => "java.lang:type=Threading", :attrs => [ "ThreadCount", "CurrentCpuThreadTime", "CurrentThreadUserTime" ], :jmx_port => node[:jmxtrans][:jmx_port]
end
