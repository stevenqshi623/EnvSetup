root = File.absolute_path(File.dirname(__FILE__))

file_cache_path root + "/tmp"
cookbook_path root + "/cookbooks"
data_bag_path root + "/data_bags"

ssl_verify_mode :verify_peer
