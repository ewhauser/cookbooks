include_recipe "jmxtrans"

jmxtrans_query "heap" do
  options :obj => "java.lang:type=Memory", :attrs => [ "HeapMemoryUsage", "NonHeapMemoryUsage" ], :jmx_port => node[:jmxtrans][:jmx_port]
end
