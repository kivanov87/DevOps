docker_service 'default' do
    action [:create, :start]
  end
  
  
  # Pull latest image
  docker_image 'nginx' do
    tag 'latest'
    action :pull
  end
  
  
  # Run container exposing ports
  docker_container 'my_nginx' do
    repo 'nginx'
    tag 'latest'
    port '80:80'
  end