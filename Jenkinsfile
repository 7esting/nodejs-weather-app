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
  stages {
    stage('Build') {
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
      }
      steps {
        echo 'Building..'
      }
    }
    stage('Test') {
      steps {
        echo 'Testing..'
      }
    }
    stage('Deploy') {
      steps {
        echo 'Deploying....'
      }
      steps {
        sh 'echo "Deployed to AWS at $(date)" |mail -s "Deployed to AWS" hector'
      }
    }
  }
}
// Script
/*
node {
  stage 'Checkout'
  git 'ssh://git@github.com:irwin-tech/docker-pipeline-demo.git'
 
  stage 'Docker build'
  docker.build('demo')
 
  stage 'Docker push'
  docker.withRegistry('https://1234567890.dkr.ecr.us-east-1.amazonaws.com', 'ecr:us-east-1:demo-ecr-credentials') {
    docker.image('demo').push('latest')
  }
}
*/