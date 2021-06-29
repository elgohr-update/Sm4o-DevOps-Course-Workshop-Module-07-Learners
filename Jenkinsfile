pipeline {
    agent any
    environment { 
	DOTNET_CLI_HOME='/tmp/dotnet_cli_home'
    }

    stages {
	stage('Checkout source code') {
	    steps {
	        checkout scm
	    }
        }

	stage('.NET Stage') {
	    agent {
		docker {
		    image 'mcr.microsoft.com/dotnet/sdk:5.0'
		}
	    }
	    steps {
		sh 'dotnet build'
		sh 'dotnet test'
	    }
	}

	stage('NPM Stage') {
	    agent {
		docker {
		    image 'node:14-alpine'
		}
  	    }
	    stages {
	 	stage('Install NPM') {
		    steps {
			dir("DotnetTemplate.Web") {
		 	    sh 'npm install'
			} 
		    }
		}
	 	stage('Build Typescript') {
		    steps {
			dir("DotnetTemplate.Web") {
		 	    sh 'npm run build'
			} 
		    }
		}
	 	stage('Lint Typescript') {
		    steps {
			dir("DotnetTemplate.Web") {
		 	    sh 'npm run lint'
			} 
		    }
		}
	 	stage('Test Typescript') {
		    steps {
			dir("DotnetTemplate.Web") {
		 	    sh 'npm t'
			} 
		    }
		}
	    }
	}
    }

}
