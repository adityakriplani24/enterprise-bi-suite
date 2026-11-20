"""Optional Slack webhook / SMTP alert delivery. Configure credentials as environment variables."""
import os, json, smtplib, urllib.request
from pathlib import Path
from email.message import EmailMessage
ROOT=Path(__file__).resolve().parents[1]
def send():
 p=ROOT/"outputs/alerts.txt"
 if not p.exists(): print("No alert preview. Run pipeline first."); return
 body=p.read_text(); hook=os.getenv("SLACK_WEBHOOK_URL")
 if hook:
  req=urllib.request.Request(hook,data=json.dumps({"text":body}).encode(),headers={"Content-Type":"application/json"})
  urllib.request.urlopen(req,timeout=15).read()
 if all(os.getenv(k) for k in ["SMTP_HOST","SMTP_USER","SMTP_PASSWORD","ALERT_TO"]):
  msg=EmailMessage(); msg["Subject"]="Supply Chain Control Tower Alert"; msg["From"]=os.environ["SMTP_USER"]; msg["To"]=os.environ["ALERT_TO"]; msg.set_content(body)
  with smtplib.SMTP(os.environ["SMTP_HOST"],int(os.getenv("SMTP_PORT","587"))) as s: s.starttls(); s.login(os.environ["SMTP_USER"],os.environ["SMTP_PASSWORD"]); s.send_message(msg)
 if not hook and not os.getenv("SMTP_HOST"): print("Credentials not configured; preview only:\n"+body)
if __name__=="__main__": send()
