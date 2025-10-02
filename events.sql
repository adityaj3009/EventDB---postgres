-- Users table
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    full_name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Venues table
CREATE TABLE venues (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    city TEXT
);

-- Events table
CREATE TABLE events (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    venue_id INT REFERENCES venues(id),
    start_ts TIMESTAMPTZ NOT NULL,
    end_ts TIMESTAMPTZ NOT NULL,
    base_price NUMERIC(8,2) NOT NULL,
    tags TEXT[] DEFAULT ARRAY[]::TEXT[],
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Orders table
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    total_amount NUMERIC(10,2) NOT NULL,
    payment_method TEXT,
    status TEXT DEFAULT 'pending'  -- pending, paid, cancelled
);

-- Tickets table
CREATE TABLE tickets (
    id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(id) ON DELETE CASCADE,
    event_id INT REFERENCES events(id),
    seat TEXT,
    price NUMERIC(8,2) NOT NULL,
    checked_in BOOLEAN DEFAULT FALSE
);

-- Attendance log table
CREATE TABLE attendance_log (
    id BIGSERIAL PRIMARY KEY,
    event_id INT REFERENCES events(id),
    ts TIMESTAMPTZ DEFAULT NOW(),
    action TEXT  -- view, purchase, checkin
);