/******************************************************************************
 * Jenkinsfile (Declarative Pipeline)
 * Created by: Me
 * Created: 05-MAY-2020
 * Version: 0.0.3
 * Region: us-east-1 (N. Virginia)
 * Amazon ECR: njs
 * Comments:
 *  Make Amazon ECR repository name the same as the Docker image name.
 ******************************************************************************/
pipeline {
  agent any
  options {
    skipDefaultCheckout(true)
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
            string(name: 'PERSON', defaultValue: 'Jenkins', description: 'Person who triggered the build.')
        }
      }
        steps {
          echo "${PERSON}, has triggered the build."
          echo 'Building Docker image...'
          sh 'docker build -t njs .'
          echo 'Tag Docker image...'
          sh 'docker tag njs:latest 686378364795.dkr.ecr.us-east-1.amazonaws.com/njs:latest'
          echo 'Docker image tagged...'
        }
    }
    stage('3. Push Docker image') {
      steps {
        echo 'Pushing image to Amazon ECR...'
        script {
          docker.withRegistry('https://686378364795.dkr.ecr.us-east-1.amazonaws.com', 'ecr:us-east-1:demo-ecr-credentials') {
            docker.image('njs').push('latest')
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
    environment {
        AWS_CLI_PATH = '/usr/local/bin'
    }
    stage('5. Deploy') {
      steps {
        echo 'Deploying...'
        // withAWS(region:'us-east-1', role: 'JenkinsRole') {
        // withAWS(region:'us-east-1', credentials: 'demo-ecr-credentials') {
          // do something
          sh '${AWS_CLI_PATH}/aws ecs list-tasks --cluster ecs-njs --region us-east-1'
          sh '${AWS_CLI_PATH}/aws ecs update-service --cluster ecs-njs --service njs-service --region us-east-1 --force-new-deployment'
          sh '${AWS_CLI_PATH}/aws ecs list-tasks --cluster ecs-njs --region us-east-1'
        // }
        /*
        script {
          'aws ecr list-images --repository-name njs --region us-east-1'
        }
        */
        echo 'Local Docker images'
        sh 'docker image ls |grep -in ecr'
        echo 'Deloyed...'
      }
    }
  }
}
