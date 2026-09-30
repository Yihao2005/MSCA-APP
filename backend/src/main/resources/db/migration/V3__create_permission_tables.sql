CREATE TABLE permissions (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    code VARCHAR(100) NOT NULL,
    description TEXT,

    CONSTRAINT uq_permissions_code UNIQUE(code)
);

CREATE TABLE user_permissions(
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    user_id BIGINT NOT NULL,
    permission_id BIGINT NOT NULL,

    scope VARCHAR(20) NOT NULL
        CHECK (scope IN (
            'OWN',
            'DEPARTMENT',
            'ALL'
            )),

    granted_by BIGINT NOT NULL,
    granted_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT uq_user_permissions_user_permission
        UNIQUE (user_id, permission_id),

    CONSTRAINT fk_user_permissions_user
        FOREIGN KEY (user_id)
        REFERENCES users(id),

    CONSTRAINT fk_user_permissions_permission
        FOREIGN KEY (permission_id)
        REFERENCES permissions(id),

    CONSTRAINT fk_user_permissions_granted_by
        FOREIGN KEY (granted_by)
        REFERENCES users(id)
);