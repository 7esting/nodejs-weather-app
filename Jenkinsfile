/******************************************************************************
 * Jenkinsfile (Declarative Pipeline)
 * Created by: Me
 * Created: 05-MAY-2020
 * Version: 0.0.3
 * Region: us-west-1 (N. California)
 * Amazon ECR: dev-njs-ui
 * Comments:
 *  Make Amazon ECR repository name the same as the Docker image name.
 ******************************************************************************/
pipeline {
  agent any
  options {
    skipDefaultCheckout(true)
  }
  environment {
    AWS_CLI_PATH = '/usr/local/bin'
  }
  stages {
    stage('1. SCM Checkout') {
      steps {
        //git credentialsId: 'github-nodejs-weather-app', url: 'https://github.com/7esting/nodejs-weather-app.git'
        checkout scm
      }
    }
    stage('2. Build Docker image') {
      input {
        message "Should we continue?"
        ok "Yes, we should."
        submitter "alice,bob"
        parameters {
            string(name: 'NAME', defaultValue: 'Jenkins', description: 'Person who triggered the build.')
        }
      }
        steps {
          echo "${NAME}, has triggered the build."
          echo 'Building Docker image...'
          sh 'docker build -t njs .'
          echo 'Tag Docker image...'
          sh 'docker tag dev-njs-ui:latest 686378364795.dkr.ecr.us-west-1.amazonaws.com/dev-njs-ui:latest'
          echo 'Docker image tagged...'
        }
    }
    stage('3. Push Docker image') {
      steps {
        echo 'Pushing image to Amazon ECR...'
        script {
          docker.withRegistry('https://686378364795.dkr.ecr.us-west-1.amazonaws.com', 'ecr:us-west-1:demo-ecr-credentials') {
            docker.image('dev-njs-ui').push('latest')
          }
        }
        echo 'Docker image pushed to Amazon ECR...'
      }
    }
    stage('4. Test') {
      steps {
        echo 'Testing...'
      }
    }
    stage('5. Deploy') {
      steps {
        echo 'Deploying...'
          sh '${AWS_CLI_PATH}/aws ecs list-tasks --cluster dev-UI --region us-west-1'
          sh '${AWS_CLI_PATH}/aws ecs update-service --cluster dev-UI --service njs-ui-service --region us-west-1 --force-new-deployment'
          sh '${AWS_CLI_PATH}/aws ecs list-tasks --cluster dev-UI --region us-west-1'
        /*
        script {
          'aws ecr list-images --repository-name dev-njs-ui --region us-west-1'
        }
        */
        echo 'Local Docker images'
        sh 'docker image ls |grep -in ecr'
        echo 'Deloyed...'
      }
    }
  }
}
