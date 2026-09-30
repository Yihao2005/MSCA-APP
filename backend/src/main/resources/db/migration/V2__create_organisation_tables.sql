CREATE TABLE departments (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    name VARCHAR(100) NOT NULL,
    description TEXT,

    status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE'
                         CHECK(
                             status IN ('ACTIVE', 'INACTIVE')
                             ),

    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT uq_department_name UNIQUE (name)
);

CREATE TABLE roles (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    code VARCHAR(50) NOT NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT,

    CONSTRAINT uq_roles_code UNIQUE (code)
);

CREATE TABLE committee_profiles (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    user_id BIGINT NOT NULL,
    department_id BIGINT,
    role_id BIGINT NOT NULL,

    leadership_title VARCHAR(100),
    wechat_id VARCHAR(100),

    join_year INTEGER NOT NULL,
    join_semester VARCHAR(20) NOT NULL
                                CHECK(
                                    join_semester IN ('SEMESTER_1', 'SEMESTER_2')
                                    ),

    status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE'
                                CHECK(
                                    status IN ('ACTIVE', 'INACTIVE')
                                    ),

    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT uq_committee_profiles_user UNIQUE(user_id),

    CONSTRAINT fk_committee_profiles_user
        FOREIGN KEY (user_id)
        REFERENCES users(id),

    CONSTRAINT fk_committee_profiles_department
        FOREIGN KEY (department_id)
        REFERENCES departments(id),

    CONSTRAINT fk_committee_profiles_role
        FOREIGN KEY (role_id)
        REFERENCES roles(id)

)