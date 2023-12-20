

template = '''
apiVersion: v1
kind: Pod
metadata:
  labels:
    run: packer
  name: packer
spec:
  containers:
  - command:
    - sleep
    - "3600"
    image: hashicorp/packer
    name: packer
    '''


def buildNumber = env.BUILD_NUMBER


if (env.BRANCH_NAME === "main"){
    kaizen = "us-east-1"
}
else if (env.BRANCH_NAME === "dev"){
    kaizen = "us-east-2"
}

else if (env.BRANCH_NAME === "qa"){
    kaizen = "us-west-1"
}

else {
    error "Branch doesn`t supported"
}

podTemplate(cloud: 'kubernetes', label: 'packer', showRawYaml: false, yaml: template){
node("packer"){
container("packer"){

stage ("Checkout SCM") {
    git branch: 'main', url: 'https://github.com/kaizenacademy/jenkins-july.git'
}

withCredentials([usernamePassword(credentialsId: 'aws-creds', passwordVariable: 'AWS_SECRET_ACCESS_KEY', usernameVariable: 'AWS_ACCESS_KEY_ID')]) {
withEnv(["AWS_REGION=${kaizen}"]) {

stage("Packer"){
  sh """
  cd packer
  packer init .
  packer build -var 'jenkins_build_number=${buildNumber}' packer.pkr.hcl
  """
}
}
}
}
}
}
