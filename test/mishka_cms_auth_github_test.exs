# SPDX-FileCopyrightText: 2026 Mishka Group contributors <https://github.com/mishka-group/mishka_cms_auth_github/graphs/contributors>
#
# SPDX-License-Identifier: Apache-2.0

defmodule MishkaCmsAuthGitHubTest do
  use ExUnit.Case, async: true

  test "is a sign-in provider Assent speaks to" do
    assert MishkaCmsCore.Accounts.SignInProvider in behaviours(MishkaCmsAuthGitHub)
    assert MishkaCmsAuthGitHub.id() == "github"
    assert %{assent: Assent.Strategy.Github} = MishkaCmsAuthGitHub.oauth()
    assert MishkaCmsAuthGitHub.label() == "GitHub"
    assert %{path: "M" <> _, color: "text-" <> _} = MishkaCmsAuthGitHub.icon()
  end

  test "asks each site for a client ID and a sealed client secret" do
    assert [
             %{key: "auth.providers.github.client_id", type: :string, scope: :site},
             %{key: "auth.providers.github.client_secret", type: :secret, scope: :site}
           ] = MishkaCmsAuthGitHub.settings()
  end

  test "hands AshAuthentication nothing it does not keep" do
    assert MishkaCmsAuthGitHub.secret(:team_id, "any-site") == :error
  end

  defp behaviours(module),
    do: module.module_info(:attributes) |> Keyword.get_values(:behaviour) |> List.flatten()
end
