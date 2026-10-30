# Mishka CMS Auth GitHub

Sign in with GitHub for [Mishka CMS](https://mishka.tools/cms). Each site switches it on and
sets its own keys; no other setup is needed.

## Install

```elixir
# mix.exs
{:mishka_cms_auth_github, "~> 0.0.2"}
```

Run `mix deps.get` and restart. The package registers itself with Mishka CMS through
`mishka_installer`; there is no config to add and no migration.

## Set up

1. Make the app at GitHub → Settings → Developer settings → **OAuth Apps → New OAuth App**.
2. Authorization callback URL: `https://<your-site>/api/auth/user/provider/callback`
3. In Mishka CMS: **Settings → Security → Sign-in methods** → switch **GitHub** on. Paste the
   **Client ID** and **Client secret** into the fields that open under it, then **Save**.

The GitHub button now shows on the sign-in and registration pages.

## What it does

- The account's primary email is used, and only when GitHub says it is verified. An OAuth app takes one callback URL, so make one app per address.
- Links to an existing confirmed account with the same email, and claims one nobody confirmed.
- Makes a new account only while the site allows it, and never makes a master.
- Asks for the authenticator code when the account has two-step sign-in.
- Uses PKCE (S256) on top of the state check.
- Keeps none of GitHub's tokens.

## License

Apache-2.0
