INSERT INTO permissions (code, description)
VALUES
    ('event.create','Create events'),
    ('event.update','Update events'),
    ('event.publish','Publish event'),
    ('event.delete','Delete events'),
    ('event.read_internal', 'Read internal events'),

    ('post.create', 'Create posts'),
    ('post.update', 'Update posts'),
    ('post.publish', 'Publish posts'),
    ('post.delete', 'Delete posts'),
    ('post.read_internal', 'Read internal posts'),

    ('registration.read', 'View event registrations'),
    ('registration.approve', 'Approve or reject event registrations');