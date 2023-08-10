from apprise import Apprise, AppriseConfig
from flask import Flask, request

flask_app = Flask(__name__)
apprise_obj = Apprise()
apprise_config = AppriseConfig()
apprise_config.add('file:///usr/src/app/.apprise')
apprise_obj.add(apprise_config)

@flask_app.route('/', methods=['POST'])
def get_notifications():
    flask_app.logger.info("got new notification")

    content = request.json
    title_content = content.get('title', 'no-title')
    body_content = content.get('body', '')

    flask_app.logger.info(f"title: '{title_content}'")
    flask_app.logger.info(f"body: '{body_content}'")
    
    apprise_obj.notify(
        title=title_content,
        body=body_content
    )
    return "ok"

@flask_app.route('/alive', methods=['GET'])
def health_check():
    return "ok"
