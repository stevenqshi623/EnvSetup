# install png, jpeg, and zlib
package "libpng12-dev"
package "libjpeg-dev"
package "zlib1g-dev"

# prepare directories
directory '/usr/local/src' do
    action :create
    recursive true
end

directory '/usr/local/pkg' do
    action :create
    recursive true
end

directory '/usr/local/pkg/hdf4' do
    action :delete
    recursive true
end

# install hdf4
bash 'install_hdf4' do
    cwd "/usr/local/src"
    user 'root'
    code <<-EOH
	rm hdf*.tar.gz*
	wget http://www.ams.sunysb.edu/~qqshi/pkgs4FT/hdf-4.2.6.tar.gz
	tar xzvf hdf-4.2.6.tar.gz
	cd hdf-4.2.6
	./configure --prefix=/usr/local/pkg/hdf4 --with-zlib=/usr --with-jpeg=/usr F77=gfortran
	make
	make install
    EOH
end
