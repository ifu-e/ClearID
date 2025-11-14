;; Decentralized Identity Verification Smart Contract

;; Define the contract owner
(define-constant contract-owner 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM) ;; Replace with your address

;; Map to store user identities
(define-map identity-registry principal { 
    user-name: (string-utf8 100), 
    user-email: (string-utf8 100), 
    is-verified: bool 
})

;; Error codes
(define-constant error-unauthorized (err u1001))
(define-constant error-already-registered (err u1002))
(define-constant error-not-found (err u1003))

;; Function to register identity
(define-public (register-identity (user-name (string-utf8 100)) (user-email (string-utf8 100)))
    (begin
        ;; Check if the caller already has an identity
        (asserts! (is-none (map-get? identity-registry tx-sender)) error-already-registered)
        
        ;; Store the identity
        (map-set identity-registry tx-sender { user-name: user-name, user-email: user-email, is-verified: false })
        
        ;; Return success
        (ok true)
    )
)

;; Function to verify identity (only callable by contract owner)
(define-public (verify-identity (user-principal principal))
    (begin
        ;; Ensure only the contract owner can verify identities
        (asserts! (is-eq tx-sender contract-owner) error-unauthorized)
        
        ;; Check if the user exists
        (asserts! (is-some (map-get? identity-registry user-principal)) error-not-found)
        
        ;; Update the verified status
        (map-set identity-registry user-principal (merge (unwrap! (map-get? identity-registry user-principal) error-not-found) { is-verified: true }))
        
        ;; Return success
        (ok true)
    )
)

;; Function to get identity information
(define-read-only (get-identity (user-principal principal))
    (begin
        ;; Fetch the identity
        (match (map-get? identity-registry user-principal)
            identity-data (ok identity-data)
            (err error-not-found)
        )
    )
)

;; Function to delete identity (only callable by the user)
(define-public (delete-identity)
    (begin
        ;; Ensure the caller has an identity
        (asserts! (is-some (map-get? identity-registry tx-sender)) error-not-found)
        
        ;; Delete the identity
        (map-delete identity-registry tx-sender)
        
        ;; Return success
        (ok true)
    )
)