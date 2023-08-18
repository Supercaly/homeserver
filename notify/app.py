import os
from apprise import Apprise, AppriseConfig
from flask import Flask, request
import logging
import logging.handlers
import waitress

# Flask App
flask_app = Flask(__name__)
# Apprise Obj
apprise_obj = Apprise()

@flask_app.route('/', methods=['POST'])
def get_notifications():
    flask_app.logger.info(f"got new notification from '{request.remote_addr}' with data: '{request.data}'")

    try:
        content = request.json
        title_content = content.get('title', 'no-title')
        body_content = content.get('body', '')
    except Exception as ex:
        flask_app.logger.error(f"exception while parsing json request: {ex}")
        return "invalid json", 404

    flask_app.logger.info("request")
    flask_app.logger.info(f"  title: '{title_content}'")
    flask_app.logger.info(f"  body: '{body_content}'")
    
    apprise_obj.notify(
        title=title_content,
        body=body_content
    )
    return "ok"

@flask_app.route('/alive', methods=['GET'])
def health_check():
    return "ok"

if __name__ == "__main__":
    # Get configs from environment variable
    notify_port = os.environ['NOTIFY_PORT']
    apprise_config_path = os.environ['NOTIFY_APPRISE_CONFIG']
    log_file_path = os.environ['NOTIFY_LOG_FILE']
    log_size_bytes = int(os.environ['NOTIFY_LOG_SIZE_BYTES'])
    log_keep_num = int(os.environ['NOTIFY_LOG_KEEP_NUM'])

    # Setup logger
    logging.basicConfig(
        level=logging.INFO, 
        format='%(asctime)s : %(levelname)s : %(name)s : %(message)s',
        handlers=[
            logging.handlers.RotatingFileHandler(log_file_path, maxBytes=log_size_bytes, backupCount=log_keep_num),
            logging.StreamHandler()
        ])

    flask_app.logger.info(f"using configs from environment")
    flask_app.logger.info(f" NOTIFY_PORT={notify_port}")
    flask_app.logger.info(f" NOTIFY_APPRISE_CONFIG={apprise_config_path}")
    flask_app.logger.info(f" NOTIFY_LOG_FILE={log_file_path}")
    flask_app.logger.info(f" NOTIFY_LOG_SIZE_BYTES={log_size_bytes}")
    flask_app.logger.info(f" NOTIFY_LOG_KEEP_NUM={log_keep_num}")

    # Config Apprise
    apprise_config = AppriseConfig()
    apprise_config.add(f"file://{apprise_config_path}")
    apprise_obj.add(apprise_config)
    
    # Start server
    waitress.serve(flask_app, host='0.0.0.0', port=notify_port)
