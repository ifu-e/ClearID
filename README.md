# ClearID

## Overview

ClearID is a decentralized identity verification system that allows users to register identity information securely on-chain while giving the contract owner the authority to verify users. The contract stores essential identity details and provides controlled access, updates, and removal.

## Key Features

* User registration with name and email
* Contract owner verification system
* Identity retrieval through a read-only function
* Secure deletion of identity by the owner of the identity
* Protection against duplicate registration and unauthorized verification

## Contract Components

* **Contract Owner:** Assigned at deployment and granted exclusive verification permissions
* **Identity Map:** Stores user information including name, email, and verification status
* **Error Constants:** Prevent unauthorized actions, duplicate registration, and access to nonexistent identities
* **Public Functions:**

  * `register-identity` for user onboarding
  * `verify-identity` for owner verification
  * `delete-identity` for users removing their data
* **Read-only Function:**

  * `get-identity` for retrieving identity details

## Functional Workflow

1. A user registers their identity by providing a name and email.
2. The contract stores the identity with a default unverified status.
3. The contract owner verifies a user's identity when required.
4. Any registered user can delete their identity at any time.
5. Anyone can query a user's identity through the read-only function.

## Summary

ClearID provides a simple and transparent framework for decentralized identity management. It ensures secure storage, controlled verification, and full user autonomy over identity deletion while preserving trust through owner authorization and strict access rules.
