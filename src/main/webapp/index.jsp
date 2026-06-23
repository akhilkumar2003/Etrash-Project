<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>E-Trash - Digital Platform for E-Waste Pickup & Recycling Awareness</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <style>
        /* Landing page specific styles */
        .landing-container {
            min-height: 100vh;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        
        .navbar {
            background: rgba(255, 255, 255, 0.1);
            padding: 20px 50px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            backdrop-filter: blur(10px);
        }
        
        .logo {
            font-size: 24px;
            font-weight: bold;
        }
        
        .logo span {
            color: #ffd700;
        }
        
        .nav-links a {
            color: white;
            text-decoration: none;
            margin-left: 30px;
            padding: 8px 20px;
            border-radius: 5px;
            transition: all 0.3s;
        }
        
        .nav-links a:hover {
            background: rgba(255, 255, 255, 0.2);
        }
        
        .nav-links .btn-primary {
            background: #ffd700;
            color: #333;
        }
        
        .nav-links .btn-primary:hover {
            background: #ffed4a;
        }
        
        .hero-section {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 50px;
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .hero-content {
            flex: 1;
            padding-right: 50px;
        }
        
        .hero-content h1 {
            font-size: 48px;
            margin-bottom: 20px;
            line-height: 1.2;
        }
        
        .hero-content p {
            font-size: 18px;
            margin-bottom: 30px;
            opacity: 0.9;
            line-height: 1.6;
        }
        
        .hero-buttons {
            display: flex;
            gap: 20px;
        }
        
        .hero-buttons .btn {
            padding: 15px 30px;
            font-size: 18px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-block;
        }
        
        .hero-buttons .btn-primary {
            background: #ffd700;
            color: #333;
        }
        
        .hero-buttons .btn-primary:hover {
            background: #ffed4a;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        
        .hero-buttons .btn-secondary {
            background: transparent;
            color: white;
            border: 2px solid white;
        }
        
        .hero-buttons .btn-secondary:hover {
            background: white;
            color: #667eea;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        
        .hero-image {
            flex: 1;
            text-align: center;
        }
        
        .hero-image img {
            max-width: 100%;
            border-radius: 10px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.3);
        }
        
        .stats-section {
            display: flex;
            justify-content: space-around;
            padding: 50px;
            background: rgba(255, 255, 255, 0.1);
            margin-top: 50px;
        }
        
        .stat-item {
            text-align: center;
        }
        
        .stat-item h3 {
            font-size: 36px;
            margin-bottom: 10px;
            color: #ffd700;
        }
        
        .stat-item p {
            font-size: 16px;
            opacity: 0.9;
        }
        
        .features-section {
            padding: 80px 50px;
            background: white;
            color: #333;
        }
        
        .features-section h2 {
            text-align: center;
            font-size: 36px;
            margin-bottom: 50px;
            color: #333;
        }
        
        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 30px;
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .feature-card {
            text-align: center;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            transition: all 0.3s;
        }
        
        .feature-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
        }
        
        .feature-icon {
            font-size: 48px;
            margin-bottom: 20px;
        }
        
        .feature-card h3 {
            font-size: 20px;
            margin-bottom: 15px;
            color: #333;
        }
        
        .feature-card p {
            color: #666;
            line-height: 1.6;
        }
        
        .how-it-works {
            padding: 80px 50px;
            background: #f8f9fa;
            color: #333;
        }
        
        .how-it-works h2 {
            text-align: center;
            font-size: 36px;
            margin-bottom: 50px;
            color: #333;
        }
        
        .steps-container {
            display: flex;
            justify-content: space-around;
            max-width: 1000px;
            margin: 0 auto;
            position: relative;
        }
        
        .step {
            text-align: center;
            flex: 1;
            position: relative;
        }
        
        .step-number {
            width: 60px;
            height: 60px;
            background: #667eea;
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            font-weight: bold;
            margin: 0 auto 20px;
            position: relative;
            z-index: 2;
        }
        
        .step:not(:last-child) .step-number::after {
            content: '';
            position: absolute;
            top: 30px;
            left: 60px;
            width: 100%;
            height: 2px;
            background: #667eea;
            z-index: 1;
        }
        
        .step h3 {
            font-size: 20px;
            margin-bottom: 10px;
            color: #333;
        }
        
        .step p {
            color: #666;
            line-height: 1.6;
            max-width: 200px;
            margin: 0 auto;
        }
        
        .cta-section {
            text-align: center;
            padding: 80px 50px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        
        .cta-section h2 {
            font-size: 36px;
            margin-bottom: 20px;
        }
        
        .cta-section p {
            font-size: 18px;
            margin-bottom: 30px;
            opacity: 0.9;
        }
        
        .cta-buttons {
            display: flex;
            justify-content: center;
            gap: 20px;
        }
        
        .cta-buttons .btn {
            padding: 15px 40px;
            font-size: 18px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
        }
        
        .cta-buttons .btn-primary {
            background: #ffd700;
            color: #333;
        }
        
        .cta-buttons .btn-primary:hover {
            background: #ffed4a;
            transform: translateY(-2px);
        }
        
        .cta-buttons .btn-secondary {
            background: transparent;
            color: white;
            border: 2px solid white;
        }
        
        .cta-buttons .btn-secondary:hover {
            background: white;
            color: #667eea;
            transform: translateY(-2px);
        }
        
        .footer {
            background: #2c3e50;
            color: white;
            padding: 50px;
            text-align: center;
        }
        
        .footer-content {
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .footer-links {
            display: flex;
            justify-content: center;
            gap: 30px;
            margin: 30px 0;
        }
        
        .footer-links a {
            color: white;
            text-decoration: none;
            opacity: 0.8;
            transition: opacity 0.3s;
        }
        
        .footer-links a:hover {
            opacity: 1;
        }
        
        .copyright {
            opacity: 0.6;
            font-size: 14px;
        }
        
        @media (max-width: 768px) {
            .hero-section {
                flex-direction: column;
                text-align: center;
                padding: 30px;
            }
            
            .hero-content {
                padding-right: 0;
                margin-bottom: 30px;
            }
            
            .hero-buttons {
                justify-content: center;
            }
            
            .steps-container {
                flex-direction: column;
                gap: 30px;
            }
            
            .step:not(:last-child) .step-number::after {
                display: none;
            }
            
            .navbar {
                padding: 20px;
                flex-direction: column;
                gap: 15px;
            }
            
            .nav-links a {
                margin: 0 10px;
            }
        }
    </style>
</head>
<body>
    <div class="landing-container">
        <!-- Navigation Bar -->
        <nav class="navbar">
            <div class="logo">
                E-<span>Trash</span>
            </div>
            <div class="nav-links">
                <a href="#features">Features</a>
                <a href="#how-it-works">How It Works</a>
                <a href="#about">About</a>
                <a href="#contact">Contact:+91 6304529550</a>
                <a href="login.jsp" class="btn-primary">Login</a>
                <a href="register.jsp">Register</a>
            </div>
        </nav>
        
        <!-- Hero Section -->
        <div class="hero-section">
            <div class="hero-content">
                <h1>Transform E-Waste into Environmental Impact</h1>
                <p>Join the movement towards a cleaner planet. Schedule e-waste pickups, earn rewards, and track your environmental impact with E-Trash platform.</p>
                <div class="hero-buttons">
                    <a href="register.jsp" class="btn btn-primary">Get Started</a>
                    <a href="#how-it-works" class="btn btn-secondary">Learn More</a>
                </div>
            </div>
            <div class="hero-image">
                <!-- You can add an SVG or image here -->
                <div style="background: rgba(255,255,255,0.1); padding: 50px; border-radius: 10px;">
                    <span style="font-size: 150px;">♻️</span>
                </div>
            </div>
        </div>
        
        <!-- Stats Section -->
        <div class="stats-section">
            <div class="stat-item">
                <h3>100+</h3>
                <p>Active Users</p>
            </div>
            <div class="stat-item">
                <h3>500+</h3>
                <p>Pickups Completed</p>
            </div>
            <div class="stat-item">
                <h3>500+</h3>
                <p>kg Waste Recycled</p>
            </div>
            <div class="stat-item">
                <h3>20+</h3>
                <p>Recycling Centers</p>
            </div>
        </div>
    </div>
    
    <!-- Features Section -->
    <div id="features" class="features-section">
        <h2>Why Choose E-Trash?</h2>
        <div class="features-grid">
            <div class="feature-card">
                <div class="feature-icon">📱</div>
                <h3>Easy Pickup Scheduling</h3>
                <p>Schedule e-waste pickups with just a few clicks. Choose your preferred date and time.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">🎁</div>
                <h3>Reward Points</h3>
                <p>Earn points for every kg of e-waste recycled. Redeem them for exciting rewards.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">🌍</div>
                <h3>Environmental Impact</h3>
                <p>Track your contribution to reducing e-waste and saving the environment.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">🏪</div>
                <h3>Marketplace</h3>
                <p>Buy and sell recyclable materials directly through our platform.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">📊</div>
                <h3>Real-time Tracking</h3>
                <p>Track your pickup requests in real-time from scheduling to completion.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">🏆</div>
                <h3>Leaderboards</h3>
                <p>Compete with others and earn badges for your recycling efforts.</p>
            </div>
        </div>
    </div>
    
    <!-- How It Works Section -->
    <div id="how-it-works" class="how-it-works">
        <h2>How It Works</h2>
        <div class="steps-container">
            <div class="step">
                <div class="step-number">1</div>
                <h3>Register</h3>
                <p>Create your account as a user, recycler, or industry buyer</p>
            </div>
            <div class="step">
                <div class="step-number">2</div>
                <h3>Schedule Pickup</h3>
                <p>Request e-waste pickup with details about your waste</p>
            </div>
            <div class="step">
                <div class="step-number">3</div>
                <h3>Get QR Code</h3>
                <p>Receive a unique QR code for your pickup request</p>
            </div>
            <div class="step">
                <div class="step-number">4</div>
                <h3>Recycler Collects</h3>
                <p>Recycler scans QR and collects your e-waste</p>
            </div>
            <div class="step">
                <div class="step-number">5</div>
                <h3>Earn Rewards</h3>
                <p>Get reward points and track your impact</p>
            </div>
        </div>
    </div>
    
    <!-- Call to Action Section -->
    <div class="cta-section">
        <h2>Ready to Make a Difference?</h2>
        <p>Join thousands of users who are already contributing to a cleaner environment.</p>
        <div class="cta-buttons">
            <a href="register.jsp" class="btn btn-primary">Sign Up Now</a>
            <a href="login.jsp" class="btn btn-secondary">Login</a>
        </div>
    </div>
    
    <!-- Footer -->
    <footer class="footer">
        <div class="footer-content">
            <div class="logo" style="margin-bottom: 20px;">
                E-<span style="color: #ffd700;">Trash</span>
            </div>
            <p style="opacity: 0.8; margin-bottom: 20px;">Digital Platform for E-Waste Pickup & Recycling Awareness</p>
            <div class="footer-links">
                <a href="#features">Features</a>
                <a href="#how-it-works">How It Works</a>
                <a href="#about">About Us</a>
                <a href="#contact">Contact</a>
                <a href="#">Privacy Policy</a>
                <a href="#">Terms of Service</a>
            </div>
            <div class="copyright">
                © 2024 E-Trash. All rights reserved. | Made with ♻️ for a cleaner planet
            </div>
        </div>
    </footer>
    
    <!-- Smooth scrolling for anchor links -->
    <script>
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });
    </script>
</body>
</html>