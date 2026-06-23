/**
 * E-Trash Platform - Main JavaScript File
 * Handles all client-side functionality including validation, UI interactions, and AJAX calls
 */

// ==================== FORM VALIDATION ====================

/**
 * Validates a form based on its ID
 * @param {string} formId - The ID of the form to validate
 * @returns {boolean} - True if form is valid, false otherwise
 */
function validateForm(formId) {
    var form = document.getElementById(formId);
    if (!form) {
        console.error('Form not found: ' + formId);
        return false;
    }
    
    var inputs = form.querySelectorAll('input[required], select[required], textarea[required]');
    
    for (var i = 0; i < inputs.length; i++) {
        if (!inputs[i].value.trim()) {
            showNotification('Please fill all required fields', 'error');
            inputs[i].focus();
            return false;
        }
    }
    
    // Email validation
    var emailInput = form.querySelector('input[type="email"]');
    if (emailInput && emailInput.value) {
        if (!isValidEmail(emailInput.value)) {
            showNotification('Please enter a valid email address', 'error');
            emailInput.focus();
            return false;
        }
    }
    
    // Phone validation
    var phoneInput = form.querySelector('input[name="phone"]');
    if (phoneInput && phoneInput.value) {
        if (!isValidPhone(phoneInput.value)) {
            showNotification('Phone number must be 10 digits', 'error');
            phoneInput.focus();
            return false;
        }
    }
    
    // Password validation
    var passwordInput = form.querySelector('input[type="password"]');
    if (passwordInput && passwordInput.value) {
        if (passwordInput.value.length < 6) {
            showNotification('Password must be at least 6 characters', 'error');
            passwordInput.focus();
            return false;
        }
    }
    
    return true;
}

/**
 * Validates email format
 * @param {string} email - Email to validate
 * @returns {boolean} - True if email is valid
 */
function isValidEmail(email) {
    var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailPattern.test(email);
}

/**
 * Validates phone number (10 digits)
 * @param {string} phone - Phone number to validate
 * @returns {boolean} - True if phone is valid
 */
function isValidPhone(phone) {
    var phonePattern = /^\d{10}$/;
    return phonePattern.test(phone);
}

/**
 * Validates quantity input
 * @param {HTMLElement} input - The input element
 * @returns {boolean} - True if quantity is valid
 */
function validateQuantity(input) {
    var value = parseFloat(input.value);
    if (isNaN(value) || value <= 0) {
        showNotification('Please enter a valid positive quantity', 'error');
        input.value = '';
        return false;
    }
    return true;
}

/**
 * Validates price input
 * @param {HTMLElement} input - The input element
 * @returns {boolean} - True if price is valid
 */
function validatePrice(input) {
    var value = parseFloat(input.value);
    if (isNaN(value) || value < 0) {
        showNotification('Please enter a valid price', 'error');
        input.value = '';
        return false;
    }
    return true;
}

/**
 * Validates date (cannot be in the past)
 * @param {HTMLElement} input - The date input element
 * @returns {boolean} - True if date is valid
 */
function validateDate(input) {
    var selectedDate = new Date(input.value);
    var today = new Date();
    today.setHours(0, 0, 0, 0);
    
    if (selectedDate < today) {
        showNotification('Date cannot be in the past', 'error');
        input.value = '';
        return false;
    }
    return true;
}

/**
 * Validates time based on selected date
 * @param {HTMLElement} timeInput - The time input element
 * @param {HTMLElement} dateInput - The date input element
 * @returns {boolean} - True if time is valid
 */
function validateTime(timeInput, dateInput) {
    if (!dateInput || !dateInput.value) {
        return true;
    }
    
    var selectedDate = new Date(dateInput.value);
    var today = new Date();
    today.setHours(0, 0, 0, 0);
    
    if (selectedDate.getTime() === today.getTime()) {
        var selectedTime = timeInput.value;
        var currentTime = new Date();
        var currentHours = currentTime.getHours();
        var currentMinutes = currentTime.getMinutes();
        
        var timeParts = selectedTime.split(':');
        var selectedHours = parseInt(timeParts[0]);
        var selectedMinutes = parseInt(timeParts[1]);
        
        if (selectedHours < currentHours || (selectedHours === currentHours && selectedMinutes < currentMinutes)) {
            showNotification('Time cannot be in the past for today', 'error');
            timeInput.value = '';
            return false;
        }
    }
    return true;
}

// ==================== NOTIFICATION SYSTEM ====================

/**
 * Shows a notification message
 * @param {string} message - The message to display
 * @param {string} type - The type of notification (success, error, info)
 */
function showNotification(message, type) {
    // Remove existing notification
    var existingNotification = document.querySelector('.notification');
    if (existingNotification) {
        existingNotification.remove();
    }
    
    // Create notification element
    var notification = document.createElement('div');
    notification.className = 'notification ' + type;
    notification.innerHTML = message;
    
    // Style the notification
    notification.style.position = 'fixed';
    notification.style.top = '20px';
    notification.style.right = '20px';
    notification.style.padding = '15px 20px';
    notification.style.borderRadius = '5px';
    notification.style.zIndex = '9999';
    notification.style.animation = 'slideIn 0.5s';
    
    if (type === 'success') {
        notification.style.backgroundColor = '#d4edda';
        notification.style.color = '#155724';
        notification.style.border = '1px solid #c3e6cb';
    } else if (type === 'error') {
        notification.style.backgroundColor = '#f8d7da';
        notification.style.color = '#721c24';
        notification.style.border = '1px solid #f5c6cb';
    } else {
        notification.style.backgroundColor = '#cce5ff';
        notification.style.color = '#004085';
        notification.style.border = '1px solid #b8daff';
    }
    
    document.body.appendChild(notification);
    
    // Auto-hide after 5 seconds
    setTimeout(function() {
        notification.style.animation = 'slideOut 0.5s';
        setTimeout(function() {
            if (notification.parentNode) {
                notification.remove();
            }
        }, 500);
    }, 5000);
}

// Add animation styles
var style = document.createElement('style');
style.innerHTML = `
    @keyframes slideIn {
        from {
            transform: translateX(100%);
            opacity: 0;
        }
        to {
            transform: translateX(0);
            opacity: 1;
        }
    }
    
    @keyframes slideOut {
        from {
            transform: translateX(0);
            opacity: 1;
        }
        to {
            transform: translateX(100%);
            opacity: 0;
        }
    }
`;
document.head.appendChild(style);

// Auto-hide message elements
document.addEventListener('DOMContentLoaded', function() {
    var messages = document.querySelectorAll('.message, .error');
    messages.forEach(function(message) {
        setTimeout(function() {
            message.style.transition = 'opacity 0.5s';
            message.style.opacity = '0';
            setTimeout(function() {
                if (message.parentNode) {
                    message.style.display = 'none';
                }
            }, 500);
        }, 5000);
    });
});

// ==================== CONFIRMATION DIALOGS ====================

/**
 * Shows a confirmation dialog
 * @param {string} message - The confirmation message
 * @param {function} onConfirm - Callback function when confirmed
 * @param {function} onCancel - Callback function when cancelled
 */
function showConfirmation(message, onConfirm, onCancel) {
    var confirmed = confirm(message || 'Are you sure?');
    if (confirmed && onConfirm) {
        onConfirm();
    } else if (!confirmed && onCancel) {
        onCancel();
    }
}

/**
 * Simplified confirmation for delete actions
 * @param {string} message - The confirmation message
 * @returns {boolean} - True if confirmed
 */
function confirmAction(message) {
    return confirm(message || 'Are you sure you want to perform this action?');
}

// ==================== PASSWORD MANAGEMENT ====================

/**
 * Toggles password visibility
 * @param {string} inputId - The ID of the password input
 * @param {HTMLElement} button - The toggle button
 */
function togglePassword(inputId, button) {
    var input = document.getElementById(inputId);
    if (!input) return;
    
    if (input.type === 'password') {
        input.type = 'text';
        button.textContent = 'Hide';
        button.classList.add('active');
    } else {
        input.type = 'password';
        button.textContent = 'Show';
        button.classList.remove('active');
    }
}

/**
 * Validates password strength
 * @param {string} password - The password to validate
 * @returns {object} - Validation result with score and message
 */
function checkPasswordStrength(password) {
    var result = {
        score: 0,
        message: 'Weak',
        isValid: false
    };
    
    if (!password) return result;
    
    // Length check
    if (password.length >= 8) result.score += 1;
    if (password.length >= 12) result.score += 1;
    
    // Character variety checks
    if (/[a-z]/.test(password)) result.score += 1;
    if (/[A-Z]/.test(password)) result.score += 1;
    if (/[0-9]/.test(password)) result.score += 1;
    if (/[^a-zA-Z0-9]/.test(password)) result.score += 1;
    
    // Determine strength message
    if (result.score >= 6) {
        result.message = 'Strong';
        result.isValid = true;
    } else if (result.score >= 4) {
        result.message = 'Medium';
        result.isValid = true;
    } else {
        result.message = 'Weak';
        result.isValid = false;
    }
    
    return result;
}

// ==================== QR CODE SCANNING ====================

/**
 * Simulates QR code scanning
 * @param {string} inputId - The ID of the QR code input field
 */
function simulateQRScan(inputId) {
    var qrInput = document.getElementById(inputId);
    if (!qrInput) return;
    
    // In a real application, this would trigger a QR scanner
    // For demo purposes, we'll just focus the input and show instructions
    qrInput.focus();
    showNotification('Please scan the QR code using a QR scanner device or enter manually', 'info');
    
    // Simulate scanning after 2 seconds (for demo only)
    if (confirm('Simulate QR scan? (Demo only)')) {
        qrInput.value = 'QR-' + Math.random().toString(36).substring(2, 10).toUpperCase();
        showNotification('QR code scanned successfully!', 'success');
    }
}

// ==================== SEARCH AND FILTER ====================

/**
 * Filters a table based on search input
 * @param {string} inputId - The ID of the search input
 * @param {string} tableId - The ID of the table to filter
 * @param {number} columnIndex - The column index to search in (optional)
 */
function filterTable(inputId, tableId, columnIndex) {
    var input = document.getElementById(inputId);
    if (!input) return;
    
    var filter = input.value.toUpperCase();
    var table = document.getElementById(tableId);
    if (!table) return;
    
    var rows = table.getElementsByTagName('tr');
    
    for (var i = 1; i < rows.length; i++) {
        var cells = rows[i].getElementsByTagName('td');
        var found = false;
        
        if (columnIndex !== undefined) {
            // Search in specific column
            var cell = cells[columnIndex];
            if (cell) {
                var textValue = cell.textContent || cell.innerText;
                if (textValue.toUpperCase().indexOf(filter) > -1) {
                    found = true;
                }
            }
        } else {
            // Search in all columns
            for (var j = 0; j < cells.length; j++) {
                var cell = cells[j];
                if (cell) {
                    var textValue = cell.textContent || cell.innerText;
                    if (textValue.toUpperCase().indexOf(filter) > -1) {
                        found = true;
                        break;
                    }
                }
            }
        }
        
        rows[i].style.display = found ? '' : 'none';
    }
}

/**
 * Filters by multiple criteria
 * @param {string} tableId - The ID of the table
 * @param {Object} filters - Object with column indices and values
 */
function advancedFilter(tableId, filters) {
    var table = document.getElementById(tableId);
    if (!table) return;
    
    var rows = table.getElementsByTagName('tr');
    
    for (var i = 1; i < rows.length; i++) {
        var cells = rows[i].getElementsByTagName('td');
        var showRow = true;
        
        for (var column in filters) {
            if (filters.hasOwnProperty(column)) {
                var filterValue = filters[column].toUpperCase();
                var cell = cells[parseInt(column)];
                
                if (cell) {
                    var textValue = cell.textContent || cell.innerText;
                    if (textValue.toUpperCase().indexOf(filterValue) === -1) {
                        showRow = false;
                        break;
                    }
                }
            }
        }
        
        rows[i].style.display = showRow ? '' : 'none';
    }
}

// ==================== REPORT GENERATION ====================

/**
 * Prints the current report
 */
function printReport() {
    window.print();
}

/**
 * Exports table data to CSV
 * @param {string} tableId - The ID of the table to export
 * @param {string} filename - The name of the CSV file
 */
function exportToCSV(tableId, filename) {
    var table = document.getElementById(tableId);
    if (!table) {
        showNotification('Table not found', 'error');
        return;
    }
    
    var rows = table.querySelectorAll('tr');
    var csv = [];
    
    for (var i = 0; i < rows.length; i++) {
        var row = [];
        var cols = rows[i].querySelectorAll('td, th');
        
        for (var j = 0; j < cols.length; j++) {
            // Clean the data: remove HTML tags and extra whitespace
            var data = cols[j].innerText.replace(/(\r\n|\n|\r)/gm, ' ').replace(/\s+/g, ' ').trim();
            // Escape commas by wrapping in quotes
            data = data.replace(/,/g, '');
            row.push('"' + data + '"');
        }
        
        csv.push(row.join(','));
    }
    
    var csvContent = csv.join('\n');
    var blob = new Blob([csvContent], { type: 'text/csv' });
    var url = window.URL.createObjectURL(blob);
    var a = document.createElement('a');
    a.href = url;
    a.download = filename || 'report.csv';
    a.click();
    window.URL.revokeObjectURL(url);
    
    showNotification('Report exported successfully!', 'success');
}

/**
 * Generates a chart from table data
 * @param {string} tableId - The ID of the table
 * @param {string} chartType - Type of chart (bar, line, pie)
 */
function generateChart(tableId, chartType) {
    // This would integrate with a charting library like Chart.js
    // For now, just show a notification
    showNotification('Chart generation feature coming soon!', 'info');
}

// ==================== MODAL MANAGEMENT ====================

/**
 * Opens a modal dialog
 * @param {string} modalId - The ID of the modal
 */
function openModal(modalId) {
    var modal = document.getElementById(modalId);
    if (modal) {
        modal.style.display = 'block';
        document.body.style.overflow = 'hidden';
    }
}

/**
 * Closes a modal dialog
 * @param {string} modalId - The ID of the modal
 */
function closeModal(modalId) {
    var modal = document.getElementById(modalId);
    if (modal) {
        modal.style.display = 'none';
        document.body.style.overflow = 'auto';
    }
}

/**
 * Sets up modal close on outside click
 * @param {string} modalId - The ID of the modal
 */
function setupModalClose(modalId) {
    var modal = document.getElementById(modalId);
    if (modal) {
        window.onclick = function(event) {
            if (event.target == modal) {
                modal.style.display = 'none';
                document.body.style.overflow = 'auto';
            }
        };
    }
}

// ==================== TAB MANAGEMENT ====================

/**
 * Switches between tabs
 * @param {string} tabName - The name of the tab to show
 * @param {string} tabGroup - The group of tabs (for multiple tab sets)
 */
function showTab(tabName, tabGroup) {
    var prefix = tabGroup ? tabGroup + '-' : '';
    
    // Hide all tab contents
    var tabs = document.querySelectorAll('[data-tab-group="' + (tabGroup || 'default') + '"]');
    tabs.forEach(function(tab) {
        tab.classList.remove('active');
    });
    
    // Remove active class from all buttons
    var buttons = document.querySelectorAll('[data-tab-button="' + (tabGroup || 'default') + '"]');
    buttons.forEach(function(button) {
        button.classList.remove('active');
    });
    
    // Show selected tab
    var selectedTab = document.getElementById(prefix + tabName);
    if (selectedTab) {
        selectedTab.classList.add('active');
    }
    
    // Activate clicked button
    event.target.classList.add('active');
}

// ==================== FORM RESET ====================

/**
 * Resets a form to its initial state
 * @param {string} formId - The ID of the form to reset
 */
function resetForm(formId) {
    var form = document.getElementById(formId);
    if (form) {
        form.reset();
        
        // Clear any validation messages
        var errorMessages = form.querySelectorAll('.field-error');
        errorMessages.forEach(function(msg) {
            msg.remove();
        });
    }
}

// ==================== AJAX UTILITIES ====================

/**
 * Makes an AJAX request
 * @param {string} url - The request URL
 * @param {string} method - HTTP method (GET, POST)
 * @param {Object} data - Data to send
 * @param {function} success - Success callback
 * @param {function} error - Error callback
 */
function ajaxRequest(url, method, data, success, error) {
    var xhr = new XMLHttpRequest();
    xhr.open(method, url, true);
    xhr.setRequestHeader('Content-Type', 'application/json');
    
    xhr.onload = function() {
        if (xhr.status >= 200 && xhr.status < 300) {
            if (success) {
                success(JSON.parse(xhr.responseText));
            }
        } else {
            if (error) {
                error(xhr.statusText);
            }
        }
    };
    
    xhr.onerror = function() {
        if (error) {
            error('Network error');
        }
    };
    
    xhr.send(JSON.stringify(data));
}

// ==================== PAGE SPECIFIC FUNCTIONS ====================

/**
 * Initialize dashboard charts and stats
 */
function initDashboard() {
    // Check if we're on a dashboard page
    if (document.querySelector('.stats')) {
        // Animate stats counting
        var statValues = document.querySelectorAll('.stat-box p, .stat-card p');
        statValues.forEach(function(stat) {
            var value = stat.textContent;
            if (!isNaN(parseFloat(value))) {
                animateValue(stat, 0, parseFloat(value), 1000);
            }
        });
    }
}

/**
 * Animate number counting
 * @param {HTMLElement} element - The element to animate
 * @param {number} start - Start value
 * @param {number} end - End value
 * @param {number} duration - Animation duration in ms
 */
function animateValue(element, start, end, duration) {
    var range = end - start;
    var current = start;
    var increment = end > start ? 1 : -1;
    var stepTime = Math.abs(Math.floor(duration / range));
    
    var timer = setInterval(function() {
        current += increment;
        element.textContent = current;
        if (current == end) {
            clearInterval(timer);
        }
    }, stepTime);
}

/**
 * Initialize recycling center map
 */
function initCenterMap() {
    if (document.getElementById('map')) {
        // This would integrate with Google Maps API
        showNotification('Map feature coming soon!', 'info');
    }
}

// ==================== EVENT LISTENERS ====================

document.addEventListener('DOMContentLoaded', function() {
    // Initialize dashboard
    initDashboard();
    
    // Initialize maps if present
    initCenterMap();
    
    // Setup date inputs with min date = today
    var dateInputs = document.querySelectorAll('input[type="date"]');
    var today = new Date().toISOString().split('T')[0];
    dateInputs.forEach(function(input) {
        if (!input.value) {
            input.min = today;
        }
    });
    
    // Setup time validation
    var timeInputs = document.querySelectorAll('input[type="time"]');
    timeInputs.forEach(function(timeInput) {
        timeInput.addEventListener('change', function() {
            var dateInput = this.closest('form').querySelector('input[type="date"]');
            validateTime(this, dateInput);
        });
    });
    
    // Setup quantity validation
    var quantityInputs = document.querySelectorAll('input[name="quantity"]');
    quantityInputs.forEach(function(input) {
        input.addEventListener('change', function() {
            validateQuantity(this);
        });
    });
    
    // Setup price validation
    var priceInputs = document.querySelectorAll('input[name="price"]');
    priceInputs.forEach(function(input) {
        input.addEventListener('change', function() {
            validatePrice(this);
        });
    });
    
    // Setup search inputs for instant filtering
    var searchInputs = document.querySelectorAll('.search-input');
    searchInputs.forEach(function(input) {
        input.addEventListener('keyup', function() {
            var tableId = this.getAttribute('data-table');
            var column = this.getAttribute('data-column');
            if (tableId) {
                filterTable(this.id, tableId, column ? parseInt(column) : undefined);
            }
        });
    });
    
    // Setup modals
    var modals = document.querySelectorAll('.modal');
    modals.forEach(function(modal) {
        setupModalClose(modal.id);
    });
});

// ==================== EXPORT FUNCTIONS FOR GLOBAL USE ====================

// Make functions globally available
window.validateForm = validateForm;
window.isValidEmail = isValidEmail;
window.isValidPhone = isValidPhone;
window.validateQuantity = validateQuantity;
window.validatePrice = validatePrice;
window.validateDate = validateDate;
window.validateTime = validateTime;
window.showNotification = showNotification;
window.confirmAction = confirmAction;
window.togglePassword = togglePassword;
window.simulateQRScan = simulateQRScan;
window.filterTable = filterTable;
window.advancedFilter = advancedFilter;
window.printReport = printReport;
window.exportToCSV = exportToCSV;
window.generateChart = generateChart;
window.openModal = openModal;
window.closeModal = closeModal;
window.showTab = showTab;
window.resetForm = resetForm;
window.ajaxRequest = ajaxRequest;