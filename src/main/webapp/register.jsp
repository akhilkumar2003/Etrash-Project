<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>E-Trash - Create Your Account</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <div class="container">
        <div class="register-box">
            <h2>🌿 Join E-Trash Platform</h2>
            <h3>Start Your Green Journey Today</h3>
            
            <!-- Registration Info Banner -->
            <div class="info-box" style="margin-bottom: 25px;">
                <p style="font-size: 0.9rem; margin: 0;">
                    <strong>Create your free account</strong> to dispose of e-waste responsibly, schedule pickups, 
                    earn rewards, and track your environmental impact. Registration takes less than 2 minutes!
                </p>
            </div>
            
            <% if (request.getAttribute("message") != null) { %>
                <div class="message"><%= request.getAttribute("message") %></div>
            <% } %>
            
            <% if (request.getAttribute("error") != null) { %>
                <div class="error"><%= request.getAttribute("error") %></div>
            <% } %>
            
            <form action="register" method="post">
                <div class="form-group">
                    <label>
                        Register As:
                        <span class="tooltip">
                            <span class="help-icon">?</span>
                            <span class="tooltiptext">User: To dispose e-waste and earn rewards. Recycler: To provide pickup and processing services.</span>
                        </span>
                    </label>
                    <select name="userType" id="userType" onchange="toggleFields()" required>
                        <option value="user">👤 User - I want to dispose e-waste</option>
                        <option value="recycler">👷 Recycler - I provide recycling services</option>
                    </select>
                    <small class="input-helper">Select based on how you'll use the platform</small>
                </div>
                
                <div class="form-group">
                    <label>
                        Full Name:
                        <span class="required">*</span>
                    </label>
                    <input type="text" name="name" placeholder="Enter your full name" required>
                    <small class="input-helper">Your name as it appears on official documents</small>
                </div>
                
                <div class="form-group user-field">
                    <label>
                        Email Address:
                        <span class="tooltip">
                            <span class="help-icon">?</span>
                            <span class="tooltiptext">We'll send pickup confirmations and reward notifications to this email</span>
                        </span>
                    </label>
                    <input type="email" name="email" placeholder="example@email.com">
                    <small class="input-helper">Used for account notifications and recovery</small>
                </div>
                
                <div class="form-group">
                    <label>
                        Phone Number:
                        <span class="required">*</span>
                    </label>
                    <input type="text" name="phone" placeholder="10-digit mobile number" pattern="[0-9]{10}" required>
                    <small class="input-helper">10 digits without spaces or special characters</small>
                </div>
                
                <div class="form-group user-field">
                    <label>
                        Complete Address:
                        <span class="tooltip">
                            <span class="help-icon">?</span>
                            <span class="tooltiptext">This address will be used for e-waste pickup scheduling</span>
                        </span>
                    </label>
                    <textarea name="address" placeholder="Enter your complete address with pin code"></textarea>
                    <small class="input-helper">Include street, area, city, and pin code for accurate pickups</small>
                </div>
                
                <div class="form-group recycler-field" style="display:none;">
                    <label>
                        Service Area:
                        <span class="tooltip">
                            <span class="help-icon">?</span>
                            <span class="tooltiptext">Specify the areas/cities where you provide recycling services</span>
                        </span>
                    </label>
                    <input type="text" name="serviceArea" placeholder="e.g., Mumbai, Navi Mumbai">
                    <small class="input-helper">Comma-separated list of areas you serve</small>
                </div>
                
                <div class="form-group">
                    <label>
                        Create Password:
                        <span class="required">*</span>
                    </label>
                    <input type="password" name="password" placeholder="Minimum 6 characters" minlength="6" required>
                    <small class="input-helper">Use a strong password with letters and numbers</small>
                </div>
                
                <div class="feature-highlight" style="margin: 20px 0;">
                    <p style="font-size: 0.85rem; margin: 0;">
                        ✓ By registering, you agree to help create a cleaner environment through responsible e-waste disposal
                    </p>
                </div>
                
                <button type="submit" class="btn">Create My Account</button>
            </form>
            
            <div style="margin-top: 25px; padding-top: 20px; border-top: 1px solid #e5e7eb;">
                <p style="margin-bottom: 10px;">Already have an account? <a href="login.jsp">Login here</a></p>
            </div>
            
            <!-- Benefits Section -->
            <div class="info-box" style="margin-top: 20px; background: linear-gradient(135deg, #f0fdf4 0%, #dcfce7 100%); border-left-color: var(--primary-color);">
                <h3 style="color: var(--primary-color); font-size: 1rem; margin-bottom: 10px;">What You Get:</h3>
                <ul style="margin: 0 0 0 20px; font-size: 0.85rem; line-height: 1.8;">
                    <li>🚛 <strong>Free Doorstep Pickup</strong> - Schedule at your convenience</li>
                    <li>🎁 <strong>Reward Points</strong> - Earn points for every kg recycled</li>
                    <li>📊 <strong>Impact Tracking</strong> - See your environmental contribution</li>
                    <li>🏪 <strong>Marketplace Access</strong> - Buy/sell refurbished electronics</li>
                    <li>🌍 <strong>Eco-Campaigns</strong> - Participate in awareness programs</li>
                    <li>✓ <strong>Certified Disposal</strong> - Environmentally safe processing</li>
                </ul>
            </div>
        </div>
    </div>
    
    <script>
        function toggleFields() {
            var userType = document.getElementById("userType").value;
            var userFields = document.getElementsByClassName("user-field");
            var recyclerFields = document.getElementsByClassName("recycler-field");
            
            if (userType === "user") {
                for (var i = 0; i < userFields.length; i++) {
                    userFields[i].style.display = "block";
                    var inputs = userFields[i].getElementsByTagName("input");
                    var textareas = userFields[i].getElementsByTagName("textarea");
                    for (var j = 0; j < inputs.length; j++) inputs[j].required = true;
                    for (var j = 0; j < textareas.length; j++) textareas[j].required = true;
                }
                for (var i = 0; i < recyclerFields.length; i++) {
                    recyclerFields[i].style.display = "none";
                    var inputs = recyclerFields[i].getElementsByTagName("input");
                    for (var j = 0; j < inputs.length; j++) inputs[j].required = false;
                }
            } else {
                for (var i = 0; i < userFields.length; i++) {
                    userFields[i].style.display = "none";
                    var inputs = userFields[i].getElementsByTagName("input");
                    var textareas = userFields[i].getElementsByTagName("textarea");
                    for (var j = 0; j < inputs.length; j++) inputs[j].required = false;
                    for (var j = 0; j < textareas.length; j++) textareas[j].required = false;
                }
                for (var i = 0; i < recyclerFields.length; i++) {
                    recyclerFields[i].style.display = "block";
                    var inputs = recyclerFields[i].getElementsByTagName("input");
                    for (var j = 0; j < inputs.length; j++) inputs[j].required = true;
                }
            }
        }
        
        // Add real-time password strength indicator
        document.addEventListener('DOMContentLoaded', function() {
            var passwordInput = document.querySelector('input[name="password"]');
            if (passwordInput) {
                passwordInput.addEventListener('input', function() {
                    var helper = this.nextElementSibling;
                    if (this.value.length < 6) {
                        helper.style.color = '#ef4444';
                        helper.textContent = 'Password too short (minimum 6 characters)';
                    } else if (this.value.length < 8) {
                        helper.style.color = '#f59e0b';
                        helper.textContent = 'Password strength: Fair (consider adding more characters)';
                    } else {
                        helper.style.color = '#10b981';
                        helper.textContent = 'Password strength: Good ✓';
                    }
                });
            }
        });
    </script>
</body>
</html>