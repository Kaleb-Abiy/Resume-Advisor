document.addEventListener('DOMContentLoaded', (event) => {
    const toggle = document.getElementById('modeToggle');
    const body = document.body;

    // Check for saved user preference, if any, on load of the website
    const currentMode = localStorage.getItem('mode');
    if (currentMode) {
        body.classList.add(currentMode);
        if (currentMode === 'dark-mode') {
            toggle.checked = true;
        }
    }

    toggle.addEventListener('change', () => {
        if (toggle.checked) {
            body.classList.remove('light-mode');
            body.classList.add('dark-mode');
            localStorage.setItem('mode', 'dark-mode');
        } else {
            body.classList.remove('dark-mode');
            body.classList.add('light-mode');
            localStorage.setItem('mode', 'light-mode');
        }
    });

    const form = document.getElementById('uploadForm');

    form.addEventListener('submit', function (event) {
        event.preventDefault(); // Prevent default form submission

        // // Show processing message
        processingMessage.style.display = 'block';

        // Get form data
        let formData = new FormData(form);


        // Send form data asynchronously using fetch
        fetch(form.action, {
            method: 'POST',
            body: formData,
            headers: {
                'X-CSRFToken': getCookie('csrftoken')
            }
        })
            .then(response => response.json())
            .then(data => {
                // Update response message
                const messageElement = document.getElementById('responseMessage');
                // Replace newline characters with <br> for HTML display
                let replaced_data = data.replace(/\n/g, '<br>'); 
                let new_replaced_data = replaced_data.replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>');
                messageElement.innerHTML = new_replaced_data
            })
            .catch(error => console.error('Error:', error))
            .finally(() => {
                // Hide processing message
                processingMessage.style.display = 'none';
            });
    });

    function getCookie(name) {
        let cookieValue = null;
        if (document.cookie && document.cookie !== '') {
            const cookies = document.cookie.split(';');
            for (let i = 0; i < cookies.length; i++) {
                const cookie = cookies[i].trim();
                // Does this cookie string begin with the name we want?
                if (cookie.substring(0, name.length + 1) === (name + '=')) {
                    cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                    break;
                }
            }
        }
        return cookieValue;
    }
});
