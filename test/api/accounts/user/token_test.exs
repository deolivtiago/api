defmodule Api.Accounts.User.TokenTest do
  use Api.DataCase, async: true

  import Api.Factories.UserFactory

  alias Api.Accounts.User.Token
  alias ApiWeb.Auth.Guardian
  alias Ecto.Changeset

  @id_not_found Ecto.UUID.generate()

  setup do
    {:ok, token, claims} =
      :user
      |> insert()
      |> Guardian.encode_and_sign(%{}, token_type: "refresh", ttl: {48, :hour})

    attrs =
      claims
      |> Map.put("token", token)
      |> Map.put("claims", claims)

    {:ok, attrs: attrs}
  end

  describe "changeset/1 returns a valid changeset" do
    test "when token is valid", %{attrs: attrs} do
      changeset = Token.changeset(%Token{}, attrs)

      assert %Changeset{valid?: true, changes: changes} = changeset
      assert changes.token == attrs["token"]
    end

    test "when sub is valid", %{attrs: attrs} do
      changeset = Token.changeset(%Token{}, attrs)

      assert %Changeset{valid?: true, changes: changes} = changeset
      assert changes.sub == attrs["sub"]
    end

    test "when jti is valid", %{attrs: attrs} do
      changeset = Token.changeset(%Token{}, attrs)

      assert %Changeset{valid?: true, changes: changes} = changeset
      assert changes.jti == attrs["jti"]
    end

    test "when aud is valid", %{attrs: attrs} do
      changeset = Token.changeset(%Token{}, attrs)

      assert %Changeset{valid?: true, changes: changes} = changeset
      assert changes.aud == attrs["aud"]
    end

    test "when exp is valid", %{attrs: attrs} do
      changeset = Token.changeset(%Token{}, attrs)

      assert %Changeset{valid?: true, changes: changes} = changeset
      assert changes.exp == attrs["exp"]
    end

    test "when typ is valid", %{attrs: attrs} do
      changeset = Token.changeset(%Token{}, attrs)

      assert %Changeset{valid?: true, changes: changes} = changeset
      assert changes.typ == attrs["typ"]
    end

    test "when iss is valid", %{attrs: attrs} do
      changeset = Token.changeset(%Token{}, attrs)

      assert %Changeset{valid?: true, changes: changes} = changeset
      assert changes.iss == attrs["iss"]
    end

    test "when claims is valid", %{attrs: attrs} do
      changeset = Token.changeset(%Token{}, attrs)

      assert %Changeset{valid?: true, changes: changes} = changeset
      assert changes.claims == attrs["claims"]
    end
  end

  describe "changeset/1 returns an invalid changeset" do
    test "when token is null", %{attrs: attrs} do
      attrs = Map.put(attrs, "token", nil)

      changeset = Token.changeset(%Token{}, attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert Enum.member?(errors.token, "can't be blank")
    end

    test "when token is not given", %{attrs: attrs} do
      attrs = Map.delete(attrs, "token")

      changeset = Token.changeset(%Token{}, attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert Enum.member?(errors.token, "can't be blank")
    end

    test "when token is empty", %{attrs: attrs} do
      attrs = Map.put(attrs, "token", "")

      changeset = Token.changeset(%Token{}, attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert Enum.member?(errors.token, "can't be blank")
    end

    test "when sub is null", %{attrs: attrs} do
      attrs = Map.put(attrs, "sub", nil)

      changeset = Token.changeset(%Token{}, attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert Enum.member?(errors.sub, "can't be blank")
    end

    test "when sub is not given", %{attrs: attrs} do
      attrs = Map.delete(attrs, "sub")

      changeset = Token.changeset(%Token{}, attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert Enum.member?(errors.sub, "can't be blank")
    end

    test "when sub is empty", %{attrs: attrs} do
      attrs = Map.put(attrs, "sub", "")

      changeset = Token.changeset(%Token{}, attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert Enum.member?(errors.sub, "can't be blank")
    end

    test "when jti is null", %{attrs: attrs} do
      attrs = Map.put(attrs, "jti", nil)

      changeset = Token.changeset(%Token{}, attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert Enum.member?(errors.jti, "can't be blank")
    end

    test "when jti is not given", %{attrs: attrs} do
      attrs = Map.delete(attrs, "jti")

      changeset = Token.changeset(%Token{}, attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert Enum.member?(errors.jti, "can't be blank")
    end

    test "when jti is empty", %{attrs: attrs} do
      attrs = Map.put(attrs, "jti", "")

      changeset = Token.changeset(%Token{}, attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert Enum.member?(errors.jti, "can't be blank")
    end

    test "when aud is null", %{attrs: attrs} do
      attrs = Map.put(attrs, "aud", nil)

      changeset = Token.changeset(%Token{}, attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert Enum.member?(errors.aud, "can't be blank")
    end

    test "when aud is not given", %{attrs: attrs} do
      attrs = Map.delete(attrs, "aud")

      changeset = Token.changeset(%Token{}, attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert Enum.member?(errors.aud, "can't be blank")
    end

    test "when aud is empty", %{attrs: attrs} do
      attrs = Map.put(attrs, "aud", "")

      changeset = Token.changeset(%Token{}, attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert Enum.member?(errors.aud, "can't be blank")
    end

    test "when exp is null", %{attrs: attrs} do
      attrs = Map.put(attrs, "exp", nil)

      changeset = Token.changeset(%Token{}, attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert Enum.member?(errors.exp, "can't be blank")
    end

    test "when exp is not given", %{attrs: attrs} do
      attrs = Map.delete(attrs, "exp")

      changeset = Token.changeset(%Token{}, attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert Enum.member?(errors.exp, "can't be blank")
    end

    test "when exp is empty", %{attrs: attrs} do
      attrs = Map.put(attrs, "exp", "")

      changeset = Token.changeset(%Token{}, attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert Enum.member?(errors.exp, "can't be blank")
    end

    test "when typ is null", %{attrs: attrs} do
      attrs = Map.put(attrs, "typ", nil)

      changeset = Token.changeset(%Token{}, attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert Enum.member?(errors.typ, "can't be blank")
    end

    test "when typ is not given", %{attrs: attrs} do
      attrs = Map.delete(attrs, "typ")

      changeset = Token.changeset(%Token{}, attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert Enum.member?(errors.typ, "can't be blank")
    end

    test "when typ is empty", %{attrs: attrs} do
      attrs = Map.put(attrs, "typ", "")

      changeset = Token.changeset(%Token{}, attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert Enum.member?(errors.typ, "can't be blank")
    end

    test "when iss is null", %{attrs: attrs} do
      attrs = Map.put(attrs, "iss", nil)

      changeset = Token.changeset(%Token{}, attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert Enum.member?(errors.iss, "can't be blank")
    end

    test "when iss is not given", %{attrs: attrs} do
      attrs = Map.delete(attrs, "iss")

      changeset = Token.changeset(%Token{}, attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert Enum.member?(errors.iss, "can't be blank")
    end

    test "when iss is empty", %{attrs: attrs} do
      attrs = Map.put(attrs, "iss", "")

      changeset = Token.changeset(%Token{}, attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert Enum.member?(errors.iss, "can't be blank")
    end

    test "when claims is null", %{attrs: attrs} do
      attrs = Map.put(attrs, "claims", nil)

      changeset = Token.changeset(%Token{}, attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert Enum.member?(errors.claims, "can't be blank")
    end

    test "when claims is not given", %{attrs: attrs} do
      attrs = Map.delete(attrs, "claims")

      changeset = Token.changeset(%Token{}, attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert Enum.member?(errors.claims, "can't be blank")
    end

    test "when claims is empty", %{attrs: attrs} do
      attrs = Map.put(attrs, "claims", "")

      changeset = Token.changeset(%Token{}, attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert Enum.member?(errors.claims, "can't be blank")
    end

    test "when claims is invalid", %{attrs: attrs} do
      attrs = Map.put(attrs, "claims", "invalid_format")

      changeset = Token.changeset(%Token{}, attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert Enum.member?(errors.claims, "is invalid")
    end

    test "when claims has invalid format", %{attrs: attrs} do
      attrs = Map.put(attrs, "claims", [])

      changeset = Token.changeset(%Token{}, attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert Enum.member?(errors.claims, "is invalid")
    end
  end

  describe "insert/1 get_by/1 and delete/1 return" do
    test ":ok when attrs are valid", %{attrs: %{"jti" => jti} = attrs} do
      assert {:ok, %{sub: sub}} = Token.get(jti)
      assert {:ok, user_token} = Token.get_by(sub: sub)
      assert {:ok, %Token{}} = Token.delete(user_token)
      assert {:ok, user_token} = Token.insert(attrs)

      assert user_token.token == attrs["token"]
      assert user_token.sub == attrs["sub"]
      assert user_token.jti == attrs["jti"]
      assert user_token.exp == attrs["exp"]
      assert user_token.typ == attrs["typ"]
      assert user_token.aud == attrs["aud"]
      assert user_token.iss == attrs["iss"]
      assert user_token.claims == attrs["claims"]
    end

    test ":error when attrs are invalid" do
      assert {:error, %Changeset{}} = Token.get(@id_not_found)
      assert {:error, changeset} = Token.get_by(sub: @id_not_found)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert Enum.member?(errors.sub, "not found")
    end
  end
end
