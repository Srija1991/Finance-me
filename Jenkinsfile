pipeline {
  agent any

  tools {
      maven 'maven'
      terraform 'terraform'
        }
environment {
        AWS_ACCESS_KEY_ID = '${Access_Key}'
        AWS_SECRET_KEY = '${Secret_Key}'
        }


  stages {
     stage('checkout'){
       steps {
         echo 'checkout the code from GitRepo'
          git 'https://github.com/Srija1991/Finance-me.git'
                    }
            }
   

     stage('Build the  Application'){
               steps {
                   echo "Cleaning.... Compiling......Testing.........Packaging"
                   sh 'mvn clean package'
                    }
                 }
     stage('publish Reports'){
               steps {
               publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: '/var/lib/jenkins/workspace/Finance-me/target/surefire-reports', reportFiles: 'index.html', reportName: 'HTML Report', reportTitles: '', useWrapperFileDirectly: true])    
                    }
            }

     stage('Docker Image Creation'){
               steps {
                      sh 'docker build -t srija1991/financeme .'
                      }
                   }


      stage('Push Image to DockerHub'){
               steps {
                   withCredentials([usernamePassword(credentialsId: 'logindocker', passwordVariable: 'docker_pswd', usernameVariable: 'docker_usr')]) {
                   sh "docker login -u ${env.docker_usr} -p ${env.docker_pswd}"
                   echo "*******************************Docker LOGIN Successful***************************************************"
                      }
                 }
            }

     stage('Push Image to docker Hub'){
        steps{
           sh 'docker push srija1991/financeme' 
                echo "*********************************************Image pushed succesfully onto DockerHUB************************************************"
      }
}
	     stage('Terraform init'){
        steps {
         dir('test-server'){
            sh 'terraform init'
              }
	}
     }    
	  
	  stage('Terraform fmt'){
        steps {
	dir('test-server'){
            sh 'terraform fmt'
              }
	}
     }    

      stage('Terraform validate'){
        steps {
		dir('test-server'){
            sh 'terraform validate'
		}
              }

     }

            stage('Terraform plan'){
        steps {
		dir('test-server'){
            sh 'terraform plan'
              }
	}
     }

     stage('Terraform apply'){
        steps {
		dir('test-server'){
            sh 'terraform apply -auto-approve'
		sleep 10
              } 
	   }
     }
     stage ('Configure Test-server with Terraform, Ansible and then Deploying'){
            steps {
                dir('test-server'){
                sh 'sudo chmod 600 dec29.ppk'
                sh 'terraform init'
                sh 'terraform validate'
                sh 'terraform apply --auto-approve'
                }
            }
        }
   }
}
