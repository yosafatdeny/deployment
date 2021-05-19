pipeline {
  agent any

  environment{
    CI = false
    DOCKER_TAG = getDockerTag()
  }

  stages {
    
    stage ('Install Dependencies rigup project'){
      steps{
        echo "Starts install dependencies rigup project"
        sh "npm install"
      }
    }

    //stage dua
    stage ('Test project'){
      steps{
        echo "run test script"    
      }
    } 

    //stage tiga
    stage ('Build rigup project'){
      steps{    
        sh 'npm run build'
      }
    } 

    //stage empat
    stage ('Build docker images'){
      steps{    
        script {
          app = docker.build("yosafatdeny/nodejs") 
        }    
      }
    }

    //stage lima
    stage ('push image to registry'){
      steps{    
        script{
          docker.withRegistry("https://registry.hub.docker.com", "dockerhub"){
            app.push("${DOCKER_TAG}")
            app.push("latest")    
          }    
        }    
      }    
    }  

    //stage enam
    stage ('deploy app to kubernetes cluster'){
      steps{    
        sh "chmod +x changeTag.sh"
        sh "./changeTag.sh ${DOCKER_TAG}"
        withKubeConfig([credentialsId: 'kubeconfig-rigup', serverUrl: 'https://34.101.70.137']){
          sh 'kubectl apply -f config.k8s.yaml'    
        }      
      }    
    }
  }      
}

def getDockerTag(){
  def tag = sh script: "git rev-parse HEAD", returnStdout: true
  return tag    
}