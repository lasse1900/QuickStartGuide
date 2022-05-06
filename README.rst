Robot Framework Quick Start Guide
=================================

*Robot Framework Quick Start Guide* introduces the most important `Robot
Framework <http://robotframework.org>`_ features. You can simply browse
through it and look at the examples, but you can also use the guide as
an executable demo.

The guide itself is in the `<QuickStart.rst>`_ file.

# Some notes by Lauri:

`Quickstart <https://github.com/robotframework/QuickStartGuide/blob/master/QuickStart.rst> `

In virtual envs you need at leat following libraries:

$ pip list
Package        Version
-------------- -------
click          8.1.3
colorama       0.4.4
Flask          2.1.2
Flask-HTTPAuth 4.6.0
itsdangerous   2.1.2
Jinja2         3.1.2
MarkupSafe     2.1.1
pip            22.0.4
setuptools     62.1.0
Werkzeug       2.1.2
wheel          0.37.1
(virtual1)

and globally:
docutils       0.18.1

Start first the server with Git Bash here (new window):
[rps_server =  your file name]
[rf_client =  your file name]

source virenvs/virtual1/Scripts/activate
cd exercise2/ex2/user_dir
export FLASK_APP=rps_server.py
flask run

Start secondly the client with Git Bash here (new window):
source virenvs/virtual1/Scripts/activate
cd exercise2/ex2/user_dir
robot rf_client.robot


