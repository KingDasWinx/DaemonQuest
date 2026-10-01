//! Wire types shared by client and server.
//!
//! These are projections of the domain, never the domain itself: server rules can
//! change without breaking clients, and server secrets cannot leak through a struct.
