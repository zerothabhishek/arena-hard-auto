import json

# def render_html(questions):
#     html_template = """
#     <!DOCTYPE html>
#     <html lang="en">
#     <head>
#         <meta charset="UTF-8">
#         <meta name="viewport" content="width=device-width, initial-scale=1.0">
#         <title>Questions</title>
#     </head>
#     <body>
#         <h1>Questions</h1>
#         <ul>
#             {% for question in questions %}
#             <li>
#                 <h2>Question ID: {{ question['question_id'] }}</h2>
#                 <p>Category: {{ question['category'] }}</p>
#                 <p>Cluster: {{ question['cluster'] }}</p>
#                 <p>Turns:</p>
#                 <ul>
#                     {% for turn in question['turns'] %}
#                     <li>{{ turn['content'] }}</li>
#                     {% endfor %}
#                 </ul>
#             </li>
#             {% endfor %}
#         </ul>
#     </body>
#     </html>
#     """
#     from jinja2 import Template
#     template = Template(html_template)
#     return template.render(questions=questions)

# def to_html(jsonl_file):
#     with open(jsonl_file, 'r') as file:
#         lines = file.readlines()
    
#     questions = [json.loads(line) for line in lines]
    
#     html_content = render_html(questions)
    
#     with open("questions.html", "w") as file:
#         file.write(html_content)

# Example usage
# to_html("questions.jsonl")


import json
from string import Template

def render_html(questions):
    html_template = """
    <html>
    <body>
        <ul>
        $questions_html
        </ul>
    </body>
    </html>
    """
    
    question_template = Template("""
        <li>
            <ul>
                $turns_html
            </ul>
        </li>
    """)
    
    turn_template = Template("<li>$content</li>")
    
    questions_html = ""
    for question in questions:
        turns_html = "".join(turn_template.substitute(content=turn['content']) for turn in question['turns'])
        questions_html += question_template.substitute(turns_html=turns_html)
    
    template = Template(html_template)
    return template.substitute(questions_html=questions_html)

def to_html(jsonl_file):
    with open(jsonl_file, 'r') as file:
        lines = file.readlines()
    
    questions = [json.loads(line) for line in lines]
    
    html_content = render_html(questions)
    
    with open("questions.html", "w") as file:
        file.write(html_content)

# Example usage
to_html("questions.jsonl")
