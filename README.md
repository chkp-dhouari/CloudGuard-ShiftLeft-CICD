# Check Point CloudGuard ShiftLeft demo using node.js web app and container image:

CloudGuard ShiftLeft CLI tool is a framework that will enable you to access all the various blades that CloudGuard offers quick and easy for integration within your pipeline.
CloudGuard ShiftLeft will allow you to scan source code, Docker container images and serverless deployment packages, Terraform templates, and more. 
The ShiftLeft CLi plugin or Docker container will integrate posture management and SAST to your CI/CD deployment pipelines for any CI server.

Shiftleft SAST and static code analysis for code and container images will scan for CVEs, CWEs, Malware and credentials by leveraging Check Point ThreatCloud which is a collaborative network and cloud-driven knowledge base that delivers real-time dynamic security intelligence

```

+ ./shiftleft code-scan -s .
SourceGuard Scan Started!                    
Project name: webdemo path: .                
Scan ID: 91f51a48c254e8437d5fc2451c08b8b563c81ef8e8cc8932f4c8db81038c494a-nc7muW 
Scanning ...                                 
Analyzing ...                                
Action: BLOCK
...
File Reputation Findings:
	- Name: "Backdoor.Win32.Evilbot.a.W.dsdyg"
	  Classification:  "Malware"
	  Verdict:  "MALICIOUS"
		- SHA: adbf428cc50dfca03a30f9050ea648649bae81be75f0db35c7158c2672c7e883 Path: terraform pipeline/web.rar
	- Name: "Trojan.Win32.Generic.W.sbmrl"
	  Classification:  "Malware"
	  Verdict:  "MALICIOUS"
		- SHA: 9fe7290683da9970955808375b203340812ada3a63930bc2db88ecb956842d0f Path: terraform pipeline/myshell.rar

```

## The following blades are currently available for use within the framework:
                                                                                       
### Git code-scan	      

The code-scan blade provides Source-code security and visibility into the risk analysis of projects in Git repositories.

> shiftleft code-scan 

### iac-assessment	

The iac-assessment blade will scan Infrastructure-as-code templates, enabling DevOps and security teams to identify insecure configurations	

> shiftleft iac-assessment 

### image-scan	   

The image-scan blade will scan Docker container images for security risks and vulnerabilities

> shiftleft image-scan 
