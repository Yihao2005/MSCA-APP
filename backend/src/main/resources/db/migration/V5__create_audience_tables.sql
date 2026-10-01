CREATE TABLE audiences (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE audience_rules (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    audience_id BIGINT NOT NULL,

    type VARCHAR(20) NOT NULL
        CHECK (type IN(
            'ALL_USERS',
            'COMMITTEE',
            'DEPARTMENT',
            'USER'
        )),

    department_id BIGINT,
    user_id BIGINT,

    CONSTRAINT fk_audience_rules_audience
        FOREIGN KEY (audience_id)
        REFERENCES audiences(id),

    CONSTRAINT fk_audience_rules_department
        FOREIGN KEY (department_id)
        REFERENCES departments(id),

    CONSTRAINT fk_audience_rules_user
        FOREIGN KEY (user_id)
        REFERENCES users(id),

    CONSTRAINT chk_audience_rules_target
        CHECK(
            (
                type = 'ALL_USERS'
                AND department_id IS NULL
                AND user_id IS NULL
            )
            OR
            (
                type = 'COMMITTEE'
                AND department_id IS NULL
                AND user_id IS NULL
            )
            OR
            (
                type = 'DEPARTMENT'
                AND department_id IS NOT NULL
                AND user_id IS NULL
            )
            OR
            (
                type = 'USER'
                AND department_id IS NULL
                AND user_id IS NOT NULL
            )
        )
);