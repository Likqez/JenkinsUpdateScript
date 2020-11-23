echo -n "Please enter your Jenkins Container ID: "
read id

docker exec -u root $id wget --directory-prefix=/home/jenkins/ https://updates.jenkins.io/latest/jenkins.war
docker exec -u root $id mv /home/jenkins/jenkins.war /usr/share/jenkins
docker exec -u root $id chown jenkins:jenkins /usr/share/jenkins/jenkins.war

read -p "New 'jenkins.war' was successfully deployed. Do you want to restart Jenkins now? (yes/no) " reply

choice=$(echo $reply|sed 's/(.*)/L1/')

if [ "$choice" = 'yes' ]
then
  echo "Restarting Container.."
  docker restart $id;

elif [ "$choice" = 'no'  ]
then

  echo "You selected 'no', exiting in 3 seconds";
  echo "Keep in mind you have to restart jenkins manually :)"
  sleep 3
  exit 0
  else
echo "invalid answer, type yes or no";
fi
