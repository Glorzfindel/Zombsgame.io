<!DOCTYPE html>
<html>
<head>
    <title>Basic games</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }

        .login-container, .main-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }

        .folder {
            background-color: #f0f0f0;
            padding: 10px;
            margin: 10px 0;
        }

        .note {
            background-color: #f9f9f9;
            padding: 10px;
            margin: 5px 0;
        }

        /* Add some styles for the Tic Tac Toe game */
        #tic-tac-toe {
            margin-top: 20px;
            display: none;
        }

        #tic-tac-toe .row {
            display: flex;
        }

        #tic-tac-toe .cell {
            width: 50px;
            height: 50px;
            border: 1px solid #000;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 24px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h1>Login</h1>
        <form id="login-form">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required>

            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>

            <button type="button" onclick="login()">Login</button>
        </form>
    </div>

    <div class="main-container" style="display: none;">
        <h1>Notes and Folders</h1>
        <button onclick="createFolder()">Create Folder</button>
        <div id="folders">
            <!-- Folders will be displayed here -->
        </div>

        <!-- Add the Tic Tac Toe game -->
        <div id="tic-tac-toe">
            <h2>Tic Tac Toe</h2>
            <div class="row">
                <div class="cell" onclick="makeMove(this)"></div>
                <div class="cell" onclick="makeMove(this)"></div>
                <div class="cell" onclick="makeMove(this)"></div>
            </div>
            <div class="row">
                <div class="cell" onclick="makeMove(this)"></div>
                <div class="cell" onclick="makeMove(this)"></div>
                <div class="cell" onclick="makeMove(this)"></div>
            </div>
            <div class="row">
                <div class="cell" onclick="makeMove(this)"></div>
                <div class="cell" onclick="makeMove(this)"></div>
                <div class="cell" onclick="makeMove(this)"></div>
            </div>
        </div>
    </div>

    <script>
        function login() {
            var username = document.getElementById("username").value;
            var password = document.getElementById("password").value;

            if (username === "every" && password === "every$") {
                alert("Login successful!");
                document.querySelector(".login-container").style.display = "none";
                document.querySelector(".main-container").style.display = "block";
                loadFolders(); // Load folders and notes
            } else {
                alert("Login failed. Please check your credentials.");
            }
        }

        function createFolder() {
            var folderName = prompt("Enter folder name:");
            if (folderName) {
                var folder = document.createElement("div");
                folder.className = "folder";
                folder.innerHTML = `<h2>${folderName}</h2><button onclick="createNote(this)">Create Note</button>`;
                document.getElementById("folders").appendChild(folder);
            }
        }

        function createNote(button) {
            var noteText = prompt("Enter note text:");
            if (noteText) {
                var note = document.createElement("div");
                note.className = "note";
                note.textContent = noteText;
                button.parentNode.appendChild(note);
            }
        }

        function loadFolders() {
            var folders = Object.keys(localStorage);
            var foldersDiv = document.getElementById("folders");

            folders.forEach(function (folderName) {
                if (folderName.match(/^[A-Za-z0-9_]+$/)) {
                    var folder = document.createElement("div");
                    folder.className = "folder";
                    folder.innerHTML = `<h2>${folderName}</h2><button onclick="createNote(this)">Create Note</button>`;

                    var notes = localStorage.getItem(folderName);
                    if (notes) {
                        var notesArray = notes.split('\n');
                        notesArray.forEach(function (noteText) {
                            var note = document.createElement("div");
                            note.className = "note";
                            note.textContent = noteText;
                            folder.appendChild(note);
                        });
                    }

                    foldersDiv.appendChild(folder);
                }
            });
        }

        // Tic Tac Toe game logic
        var currentPlayer = "X";

        function makeMove(cell) {
            if (cell.textContent === "") {
                cell.textContent = currentPlayer;
                currentPlayer = currentPlayer === "X" ? "O" : "X";
            }
        }

        // Show the Tic Tac Toe game when the main container is displayed
        document.querySelector(".main-container").addEventListener("transitionend", function () {
            if (getComputedStyle(this).display !== "none") {
                document.getElementById("tic-tac-toe").style.display = "block";
            }
        });
    </script>
</body>
</html>
