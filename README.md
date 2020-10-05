# Check Point CloudGuard ShiftLeft demo using node.js web app and container image:

CloudGuard ShiftLeft enables you to add posture scanning to your CI/CD deployment pipelines.
You can scan source code, images and serverless deployment packages, Terraform templates, and more.
The ShiftLeft CLI tool is a framework that will enable you to access all the various blades that CloudGuard offers quick and easy for integration within your pipeline.

## The following blades are currently available for use within the framework:
 Blade Name	    Description	                                                                                                    Usage
code-scan	      Source-code security and visibility into the risk analysis of projects	                                        shiftleft code-scan -h
iac-assessment	Scans Infrastructure-as-code templates, enabling DevOps and security teams to identify insecure configurations	shiftleft iac-assessment -h
image-scan	    Scan container images for security risks and vulnerabilities	                                                  shiftleft image-scan -h
