from flask import Flask, render_template, request, redirect, url_for, flash # type: ignore

app = Flask(__name__)
app.secret_key = "devops_is_fun"

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/submit', methods=['POST'])
def submit():
    name = request.form.get('name')
    feedback = request.form.get('feedback')

    if not name or not feedback:
        flash("All fields are required!", "error")
        return redirect(url_for('index'))

    # Simulate saving feedback (for demo purposes)
    print(f"[Feedback] {name}: {feedback}")
    flash("Thank you for your feedback!", "success")
    return redirect(url_for('index'))

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
