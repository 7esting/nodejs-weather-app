// Jenkinsfile (Declarative Pipeline)
/*
agent --indicates that Jenkins should allocate an executor and workspace for this part of the Pipeline.
stage --describes a stage of this Pipeline.
steps --describes the steps to be run in this stage
sh --executes the given shell command
junit --is a Pipeline step provided by the plugin:junit[JUnit plugin] for aggregating test reports.
 */
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
          echo 'Building Docker image..'
          sh 'docker build -t nodejs-weather-app .'
          echo 'Tag Docker image..'
          sh 'docker tag nodejs-weather-app:latest 686378364795.dkr.ecr.us-west-1.amazonaws.com/my-ecr-demo:v1.01'
          echo 'Docker image tagged..'
        }
    }
    /*
    stage('3. Docker push') {
      steps {
        echo 'Pushing image to Amazon ECR..'
        //sh 'docker push 686378364795.dkr.ecr.us-west-1.amazonaws.com/my-ecr-demo:v1.01'
        docker.withRegistry('https://686378364795.dkr.ecr.us-west-1.amazonaws.com', 'ecr:us-west-1:demo-ecr-credentials') {
          docker.image('my-ecr-demo').push('beta2')
        }
        echo 'Docker image pushed to Amazon ECR..'
      }
    }
    */
    stage('4. Test') {
      steps {
        echo 'Testing..'
      }
    }
    stage('5. Deploy') {
      steps {
        echo 'Deploying....'
        sh 'echo "Deployed to AWS at $(date)" |mail -s "Deployed to AWS" hector'
        echo 'Deloyed..'
      }
    }
  }
}
// docker.withRegistry only allowed in script blocks not with declarative pipeline derectives 
node {
  /*
  stage 'Checkout'
  git 'ssh://git@github.com:irwin-tech/docker-pipeline-demo.git'
  
  stage 'Docker build'
  docker.build('my-ecr-demo')
  */
  stage('3. Docker push') {
    docker.withRegistry('https://686378364795.dkr.ecr.us-west-1.amazonaws.com', 'ecr:us-west-1:demo-ecr-credentials') {
    docker.image('my-ecr-demo').push('beta2')
    }
  }
}