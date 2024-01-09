# Add Multiple Sites to Cloudflare

To add multiple sites to Cloudflare at once and more efficiently, you can do so via the Cloudflare API.

## Get Started

1. Create an `.env` file in the root directory containing [**Cloudflare API**](https://developers.cloudflare.com/fundamentals/api/get-started/keys/) Key information. You can copy the content from the `.env.example` file.

```bash
CLOUDFLARE_EMAIL=YOUR_EMAIL

# Ref: https://developers.cloudflare.com/fundamentals/api/get-started/keys/
CLOUDFLARE_API_KEY=YOUR_API_KEY

# Ref: https://developers.cloudflare.com/fundamentals/setup/find-account-and-zone-ids/
ACCOUNT_ID=YOUR_ACCOUNT_ID

# IMPORTANT: Last line must be empty
```

2. Create a `domains.txt` file in the root directory that includes the domains that need to be added to Cloudflare, each domain name on a separate line (newline separated). For example:

```bash
example.com
example.net
example.org
```

> Please read the [**Limitations**](https://developers.cloudflare.com/fundamentals/setup/add-multiple-sites-automation/#limitations) section carefully.


3. Open **Terminal** and run the following command:

```bash
./add-multiple-zones.sh
```

## Acknowledgments

- https://developers.cloudflare.com/fundamentals/setup/add-multiple-sites-automation/
- https://developers.cloudflare.com/fundamentals/api/get-started/keys/
- https://developers.cloudflare.com/fundamentals/setup/find-account-and-zone-ids/