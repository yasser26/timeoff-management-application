# Continuous Integration solution using Jenkins, Docker and Azure

The main objetive of this fork is to implement a fully automated continous integration solution using Jenkins. The timeoff-management app will be checked out from this GitHub repo, then, it will be containerized using Docker to have a more flexible manage of it accross the used platforms. 

Build the docker image will be done using a Jenkins pipeline. The pipeline will have several stages; one of themm is to download the latest code version from the repositorie, build the Docker image is the next stage and the final will be push and deploy the application to cloud.

Timeoff-management docker image will be pushed to a cloud service where it can be possible track every version of produced "artifact" when a new CI/CD flow starts. The selected option is Azure Container Registry.

Finally, the application will be deployed to an Azure Web App resource where it can be accessed from any browser with internet through an URL. The cloud resources will be created using an infrastructure-as-a-code focus with the help of Azure CLI.

![image](https://user-images.githubusercontent.com/31905618/226280729-f9617e26-749a-4f2a-bf6b-25bbf2d3da9d.png)


## Needed pre-work before implement CI/CD flow

Before start any DevOps implementation, it was necessary to download and build the timeoff-management app locally to check needed dependencies and more important, the right versions of them. The applications has some time whithout recent updates, for that reason, in some environments with latest tools versions, the app produces failaures during the build.

This process took time and pacient. It was necessary analyze the logs of every build attemp, this to check which dependency was needed or was causing conflicts. After this process, below are the changes done to run the app locally and proceed with the containerization of it.

- Use "sas" instead "node-saas"
- Update sqlite3 from 4.0.1 to 4.2.0

## Dockerfile to containerize timeoff-management app

This is the used dockerfile to containerize the application. As you can see, it's a simple dockerfile but the most important benefic is that having a containerized application, we can deploy it to Azure and handle it flexibily. The docker image will use a node 18 parent image. The needed dependencies from previuos local build process are installed and finally, we use npm install and npm start install dependencies from packages json file and run the app.

![Screenshot from 2023-03-19 23-21-41](https://user-images.githubusercontent.com/31905618/226254570-15bb0801-7ef4-4663-b8b6-df27ac7fe79b.png)


## Jenkins pipeline implementation


1. It was created a new Pipeline called "time-management-Pipeline".

![image](https://user-images.githubusercontent.com/31905618/226255837-ff50c458-1e36-44d7-bace-b4d778743a4a.png)


2. During pipeline configuration. It was selected "GitHub hook trigger for GITScm polling" as build trigger. This option allows that pipeline triggers by a change on the repo. 

![Screenshot from 2023-03-19 23-42-50](https://user-images.githubusercontent.com/31905618/226257373-95863ee2-0477-41ca-90cb-c9db17a4562b.png)

It's neccesary create a webhook service on GitHub previuosly, so, the communication between Jenkins and GitHub can be established and, pipeline will be trigger when there's a push. Also, since Jenkins runs locally, it was needed the tool called "Ngrok" which allows us to tunel the port 8080 to internet.

![image](https://user-images.githubusercontent.com/31905618/226258172-27b2e3d9-eaa1-4af9-aac2-8906fd6a55e8.png)


3. Below is the Jenkinsfile which is the pipeline definition. The pipeline is conformed by three main stages. We have an automated process to download latest code version, build it on a Docker image and then, push it and deploy it to Azure.

![image](https://user-images.githubusercontent.com/31905618/226260078-185ed195-cf18-4a01-889b-7c90cbccccdd.png)


## Creation of Azure Container Registry and Azure App Services using IaaC

In order to create the needed cloud infrastructure for our timeoff-management docker image, it was used Azure CLI commands on an Powershell cloud terminal. Below are the used commands to create a Resource Group with an Azure Container Registry. The RG will be located on Brazil South and, the ACR registry needs to have the option --admin-enabled enable to have an auth identity on Jenkins.

![image](https://user-images.githubusercontent.com/31905618/226265540-83841c64-b11d-4743-aca8-3fd039498a84.png)

![image](https://user-images.githubusercontent.com/31905618/226266624-d0999a60-9a51-4571-a232-06ceaf39a0ca.png)


To create the Azure Web App, it was necessary run below commands. Fistly, it was created an App Service plan, this is where our container app will be allocated, with option --is-linux we define the linux OS preference.

Finally, it was created the web app resource, important to note the option --deployment-container-image-name which it's used to create the continuos deployment of the application, so, when there's a new image version on ACR, the Web App will pull the image from that cloud resource.

![image](https://user-images.githubusercontent.com/31905618/226268194-0fe2bba9-7225-4362-81fd-dbe0427aff21.png)

![image](https://user-images.githubusercontent.com/31905618/226269376-a0847921-c2b4-42af-9339-e24e48ae91af.png)


## Conclusions

It was possible to implement a fully automated CI/CD flow of timeoff-management-application using principals DevOps concepts. Starting with a fork of principal project's repo, the application was tested locally to determine the necessary dependencies and their compatible versions. During this process, it was necessary use "saas" instead "node-saas" and upgrade the require "sqlite3" version.

Then, it was decided to use a containerized app using Docker to have versatibility while handling the app accross the different used platform, from locallty to cloud. 

A Jenkins pipeline implemets the continuos integration part of this flow. Throught a webhook service, it's possible to trigger the pipeline when there's a change on this GitHub repo. Using the Dockerfile, the pipeline can create the docker image with lastest code.

Our artifacts are the created docker images when the pipeline triggers. So, to have track over diferent versions and follow a correct artifact management, it was used Azure Container Registry as a cloud solution. The Jenkins pipeline after build the docker image, will push it to ACR with latest tag.

Finally, it was possible to implement the continuos deployment by connecting an Azure Web App running linux to the ACR. Every time there's a new image latest version, the Web App will be updated having the application always updated and implementing a basic DevOps methodoloy.

![Screenshot from 2023-03-20 01-05-18](https://user-images.githubusercontent.com/31905618/226273669-6562dc7d-62fd-4a22-8757-ff4db4168e05.png)

![image](https://user-images.githubusercontent.com/31905618/226275127-8d355b5f-ed60-4454-975c-d005484e95f2.png)






# TimeOff.Management

Web application for managing employee absences.

<a href="https://travis-ci.org/timeoff-management/timeoff-management-application"><img align="right" src="https://travis-ci.org/timeoff-management/timeoff-management-application.svg?branch=master" alt="Build status" /></a>

## Features

**Multiple views of staff absences**

Calendar view, Team view, or Just plain list.

**Tune application to fit into your company policy**

Add custom absence types: Sickness, Maternity, Working from home, Birthday etc. Define if each uses vacation allowance.

Optionally limit the amount of days employees can take for each Leave type. E.g. no more than 10 Sick days per year.

Setup public holidays as well as company specific days off.

Group employees by departments: bring your organisational structure, set the supervisor for every department.

Customisable working schedule for company and individuals.

**Third Party Calendar Integration**

Broadcast employee whereabouts into external calendar providers: MS Outlook, Google Calendar, and iCal.

Create calendar feeds for individuals, departments or entire company.

**Three Steps Workflow**

Employee requests time off or revokes existing one.

Supervisor gets email notification and decides about upcoming employee absence.

Absence is accounted. Peers are informed via team view or calendar feeds.

**Access control**

There are following types of users: employees, supervisors, and administrators.

Optional LDAP authentication: configure application to use your LDAP server for user authentication.

**Ability to extract leave data into CSV**

Ability to back up entire company leave data into CSV file. So it could be used in any spreadsheet applications.

**Works on mobile phones**

The most used customer paths are mobile friendly:

* employee is able to request new leave from mobile device

* supervisor is able to record decision from the mobile as well.

**Lots of other little things that would make life easier**

Manually adjust employee allowances
e.g. employee has extra day in lieu.

Upon creation employee receives pro-rated vacation allowance, depending on start date.

Email notification to all involved parties.

Optionally allow employees to see the time off information of entire company regardless of department structure.

## Screenshots

![TimeOff.Management Screenshot](https://raw.githubusercontent.com/timeoff-management/application/master/public/img/readme_screenshot.png)

## Installation

### Cloud hosting

Visit http://timeoff.management/

Create company account and use cloud based version.

### Self hosting

Install TimeOff.Management application within your infrastructure:

(make sure you have Node.js (>=4.0.0) and SQLite installed)

```bash
git clone https://github.com/timeoff-management/application.git timeoff-management
cd timeoff-management
npm install
npm start
```
Open http://localhost:3000/ in your browser.

## Run tests

We have quite a wide test coverage, to make sure that the main user paths work as expected.

Please run them frequently while developing the project.

Make sure you have Chrome driver installed in your path and Chrome browser for your platform.

If you want to see the browser execute the interactions prefix with `SHOW_CHROME=1`

```bash
USE_CHROME=1 npm test
```

(make sure that application with default settings is up and running)

Any bug fixes or enhancements should have good test coverage to get them into "master" branch.

## Updating existing instance with new code

In case one needs to patch existing instance of TimeOff.Managenent application with new version:

```bash
git fetch
git pull origin master
npm install
npm run-script db-update
npm start
```

## How to?

There are some customizations available.

## How to amend or extend colours available for colour picker?
Follow instructions on [this page](docs/extend_colors_for_leave_type.md).

## Customization

There are few options to configure an installation.

### Make sorting sensitive to particular locale

Given the software could be installed for company with employees with non-English names there might be a need to
respect the alphabet while sorting customer entered content.

For that purpose the application config file has `locale_code_for_sorting` entry.
By default the value is `en` (English). One can override it with other locales such as `cs`, `fr`, `de` etc.

### Force employees to pick type each time new leave is booked

Some organizations require employees to explicitly pick the type of leave when booking time off. So employee makes a choice rather than relying on default settings.
That reduce number of "mistaken" leaves, which are cancelled after.

In order to force employee to explicitly pick the leave type of the booked time off, change `is_force_to_explicitly_select_type_when_requesting_new_leave`
flag to be `true` in the `config/app.json` file.

## Use Redis as a sessions storage

Follow instructions on [this page](docs/SessionStoreInRedis.md).

## Feedback

Please report any issues or feedback to <a href="https://twitter.com/FreeTimeOffApp">twitter</a> or Email: pavlo at timeoff.management

