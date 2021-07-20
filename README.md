<h1>Introduction</h1>
Dear community,<br/>
<br/>
this is my first attempt creating a more sophisticated app (DDD, firebase, unit tests). The idea of this app is to combine a diary app, life/sports tracking app, social media app and survey app in one app.<br/>
<br/>
The users can create "chatbots" and fill them with questions of different types (numeric, time, multiple choice, yes/no) and share them with other users. If a user subscribes a "chatbot", the "chatbot" will ask the user its questions on a daily basis at a specific time. Any kind of question is possible: daily life-related topics like in a diary, sports-related topics, emotions etc. But also opinions could be asked via the app, e.g. political surveys etc.<br/>
<br/>
<h1>Features</h1>
In the current version, the "features" are still limited:<br/>
<br/>
-register/login with email and password, google sign-in <br/>
-creation of chatbots, questions and pre-defined answer options in multiple languages <br/>
-creation of daily question-items for subscribed users and sending of push-notifications (executed on the server with firebase cloud functions) <br/>
-answering question-items in a chat with different input methods (slider, number-picker etc.) <br/>
-edit and delete answer-items in the chat via swiping <br/>
-simple analysis of answer statistic (listview and pie-chart for yes/no questions) <br/>
-multi-language <br/>
-subscribing of chatbots <br/>
<h1>ToDo</h1>
In the long run there could be more "features" avaible: <br/>
<br/>
-adding/deleting friends<br/>
-change visibility of chatbots and even answers-items (private, only friends, public)<br/>
-more analysis options (different charts, comparing answer statistic with friends, public etc.)<br/>
-search bar and categories for chatbots<br/>
-change username, password etc.<br/>
<h1>Installation</h1>
Please note that it is necessary to connect the cloned repo with an own firebase project. Otherwise it is not possible to build the project.
If you are interessted in testing the app on your device or in the emulator without doing that, please contact me. I can also provide the .apk file
<h1>Screenshots</h1>
<p float="left">
  <img src="screenshots/Screenshot_1626765789.png" width="270" height="500"/>
  <img src="screenshots/Screenshot_1626765820.png" width="270" height="500"/> 
  <img src="screenshots/Screenshot_1626765856.png" width="270" height="500"/>
</p>
<p float="left">
  <img src="screenshots/Screenshot_1626765894.png" width="270" height="500"/>
  <img src="screenshots/Screenshot_1626765906.png" width="270" height="500"/> 
  <img src="screenshots/Screenshot_1626766841.png" width="270" height="500"/>
</p>
<h1>Licence</h1>
<img src="4readme-licence.png" width="88" height="31"> <br/>
Creative Commons Lizenzvertrag<br/>
Dieses Werk ist lizenziert unter einer Creative Commons Namensnennung-Nicht kommerziell 3.0 Deutschland Lizenz.<br/>
<br/>
