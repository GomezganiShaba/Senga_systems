# Senga Systems - OAuth Setup Guide

## Setting Up Google OAuth

### Step 1: Create Google Cloud Project
1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select existing one
3. Enable the "Google+ API" or "Google Identity" API

### Step 2: Configure OAuth Consent Screen
1. Go to **APIs & Services > OAuth consent screen**
2. Choose "External" user type
3. Fill in the app information:
   - App name: `Senga Systems`
   - User support email: `gomezgani60@gmail.com`
   - Developer contact: `gomezgani60@gmail.com`
4. Add scopes: `email`, `profile`, `openid`
5. Add test users if in testing mode

### Step 3: Create OAuth Credentials
1. Go to **APIs & Services > Credentials**
2. Click **Create Credentials > OAuth client ID**
3. Application type: **Web application**
4. Name: `Senga Systems Web`
5. **Authorized JavaScript origins:**
   ```
   https://dumkawghavjsiwyosqqw.supabase.co
   http://localhost:3000
   https://yourdomain.com
   ```
6. **Authorized redirect URIs:**
   ```
   https://dumkawghavjsiwyosqqw.supabase.co/auth/v1/callback
   ```
7. Copy the **Client ID** and **Client Secret**

### Step 4: Configure in Supabase
1. Go to [Supabase Dashboard](https://supabase.com/dashboard)
2. Select your project
3. Navigate to **Authentication > Providers**
4. Find **Google** and click to enable
5. Enter your **Client ID** and **Client Secret**
6. Save changes

---

## Setting Up GitHub OAuth

### Step 1: Create GitHub OAuth App
1. Go to [GitHub Developer Settings](https://github.com/settings/developers)
2. Click **OAuth Apps > New OAuth App**
3. Fill in the details:
   - Application name: `Senga Systems`
   - Homepage URL: `https://yourdomain.com` (or `http://localhost:3000` for development)
   - Application description: `Senga Systems Cybersecurity Platform`
   - Authorization callback URL: 
     ```
     https://dumkawghavjsiwyosqqw.supabase.co/auth/v1/callback
     ```
4. Click **Register application**
5. Copy the **Client ID**
6. Generate and copy the **Client Secret**

### Step 2: Configure in Supabase
1. Go to [Supabase Dashboard](https://supabase.com/dashboard)
2. Select your project
3. Navigate to **Authentication > Providers**
4. Find **GitHub** and click to enable
5. Enter your **Client ID** and **Client Secret**
6. Save changes

---

## Testing OAuth

After configuration:

1. Visit your login page: `/auth/login.html`
2. Click "Continue with Google" or "Continue with GitHub"
3. You should be redirected to the provider's login page
4. After successful login, you'll be redirected to the dashboard

### Troubleshooting

**"Redirect URI mismatch" error:**
- Ensure the callback URL in your OAuth provider matches exactly:
  `https://dumkawghavjsiwyosqqw.supabase.co/auth/v1/callback`

**"Access blocked" error:**
- For Google: Ensure your app is verified or user is added as test user
- For GitHub: Check that the callback URL is correct

**User not redirected after login:**
- Check browser console for errors
- Verify Supabase project URL and anon key are correct in auth.js

---

## Site Redirect URL Configuration

In Supabase Dashboard > Authentication > URL Configuration:

- **Site URL:** `https://yourdomain.com` (or `http://localhost:3000`)
- **Redirect URLs:** Add all allowed redirect URLs:
  ```
  http://localhost:3000/auth/dashboard.html
  https://yourdomain.com/auth/dashboard.html
  ```

---

## Contact

For support: **gomezgani60@gmail.com**
WhatsApp: **+265 986 076 400**
