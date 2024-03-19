pipeline{
    agent any
    stages {

        stage('Getting project from GitHub') {
            steps{
      			checkout([$class: 'GitSCM', branches: [[name: '*/main']],
			extensions: [],
			userRemoteConfigs: [[url: 'https://github.com/Omar-Bensalah/technical-assessment.git']]])
            }
        }

      stage('Docker Build') {
    	agent any
          steps {
          	sh 'docker build -t omarbensalah8/technical-assessment .'
          }
         }
      stage('Docker Login') {
    	agent any
      steps {
      	withCredentials([usernamePassword(credentialsId: 'dockerHub', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
        	sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
        }
      }
    }

      stage ('Docker push to hub') {
        agent any
        steps {
          sh 'docker push omarbensalah8/technical-assessment:latest'
        }
      }

      stage ('Deploy the application to K8s cluster') {
        agent any
        steps {
          sh 'docker push omarbensalah8/technical-assessment:latest'
        }
      }
}
	    
        post {
        success {
            echo "Succesfull pipeline"
        }
  
    }	
}