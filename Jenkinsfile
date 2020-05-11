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
            string(name: 'PERSON', defaultValue: 'Mr Jenkins', description: 'Who should I say hello to?')
        }
      }
        steps {
          echo "Hello, ${PERSON}, nice to meet you."
          echo 'Building Docker image...'
          sh 'docker build -t njs .'
          echo 'Tag Docker image...'
          sh 'docker tag njs:latest 686378364795.dkr.ecr.us-east-1.amazonaws.com/njs:v0.0.1'
          echo 'Docker image tagged...'
        }
    }
    stage('3. Push Docker image') {
      steps {
        echo 'Pushing image to Amazon ECR...`date`'
        script {
          docker.withRegistry('https://686378364795.dkr.ecr.us-east-1.amazonaws.com', 'ecr:us-east-1:demo-ecr-credentials') {
            docker.image('njs').push('v0.0.1')
          }
        }
        echo 'Docker image pushed to Amazon ECR...`date`'
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
        /*
        script {
          'aws ecr list-images --repository-name my-ecr-demo'
        }
        */
        sh 'docker image ls |grep -in ecr'
        echo 'Deloyed...'
      }
    }
  }
}
