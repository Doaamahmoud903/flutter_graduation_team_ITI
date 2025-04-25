from flask import Flask, request, jsonify
from werkzeug.utils import secure_filename
from transformers import pipeline
import os
import torch

app = Flask(__name__)

# تهيئة نموذج Whisper
pipe = pipeline(
    "automatic-speech-recognition",
    model="openai/whisper-large",
    device="cuda" if torch.cuda.is_available() else "cpu"
)

# مسار مؤقت لحفظ الملفات الصوتية
UPLOAD_FOLDER = "uploads"
os.makedirs(UPLOAD_FOLDER, exist_ok=True)
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

# دالة لتحويل الصوت إلى نص
@app.route('/transcribe', methods=['POST'])
def transcribe_audio():
    if 'file' not in request.files:
        return jsonify({"error": "No file uploaded"}), 400

    file = request.files['file']
    if file.filename == '':
        return jsonify({"error": "Empty file"}), 400

    if file:
        # حفظ الملف مؤقتًا
        filename = secure_filename(file.filename)
        audio_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
        file.save(audio_path)

        # تحويل الصوت إلى نص
        try:
            result = pipe(audio_path, return_timestamps=True)
            transcription = result["text"]
            return jsonify({"text": transcription})
        except Exception as e:
            return jsonify({"error": str(e)}), 500
        finally:
            # حذف الملف بعد الانتهاء
            if os.path.exists(audio_path):
                os.remove(audio_path)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)