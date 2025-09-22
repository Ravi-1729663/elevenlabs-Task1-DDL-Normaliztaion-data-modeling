# Advanced Social Media Platform – Database Schema

## Project Overview
This project involves designing a **relational database schema** for an **advanced social media platform** using **MySQL**.  
It includes both standard social media functionalities (users, posts, comments, likes) and advanced features such as **collaborative posts, content provenance, AR scenes, local threads, and microtransactions**.

**Objective:**  
- Learn database setup, table creation, relationships, and constraints.  
- Design a **scalable, fast-read/write schema** suitable for real-world social media operations.  

---

## Tools Used
- **MySQL 8.0+**  
- **MySQL Workbench** (for ER diagram & schema visualization)  
- Optional: **pgAdmin / SQLiteStudio**  

---

## Database Setup
- **Database Name:** `connects`  
- Created using `CREATE DATABASE IF NOT EXISTS connects;`  
- All tables are created **only if they do not exist**.  

---

## Entities & Relationships

| Entity           | Description                                               |
|-----------------|-----------------------------------------------------------|
| Users           | Stores core user information                               |
| User_Profile    | Stores additional profile details                          |
| Relationships   | Tracks followers, friends, and blocks                     |
| Posts           | Stores all user posts                                      |
| Post_Attachments| Stores media metadata associated with posts               |
| Comments        | Stores comments, including nested comments                |
| Reactions       | Stores likes, loves, and other reactions                  |
| User_Feed       | Precomputed personalized feed for users                   |
| Hashtags        | Stores all hashtags                                        |
| Post_Hashtag    | Junction table connecting posts and hashtags              |

**Relationships:**  
- `Users → Posts`: One-to-Many  
- `Users ↔ Users`: Many-to-Many via `Relationships`  
- `Posts → Comments`: One-to-Many  
- `Posts ↔ Hashtags`: Many-to-Many via `Post_Hashtag`  
- `Posts ↔ Reactions`: Many-to-Many  
- `Users → User_Feed`: One-to-Many  

---

## Advanced Features (Unique to this Schema)
1. **Collaborative Posts:** Multiple authors per post.  
2. **Content Provenance:** Track post integrity and verification (blockchain-ready).  
3. **AR Scenes & Geofencing:** Posts with augmented reality content linked to locations.  
4. **Local Threads:** Location-based communities for neighborhood interactions.  
5. **Tipping & Digital Collectibles:** Wallets and micro-payments (NFTs).  

---

## Schema Design Highlights
- **Primary & Foreign Keys** ensure referential integrity.  
- **Unique constraints** prevent duplicate usernames, emails, hashtags, and reactions.  
- **JSON fields** (`metadata`, `media_meta`) allow flexible, future-proof storage.  
- **Timestamps** track creation and updates (`created_at`, `updated_at`).  
- **Soft-delete strategy** can be implemented via `status` or `is_deleted` fields.  

---

## Implementation
- SQL scripts include `IF NOT EXISTS` checks to avoid errors.  
- ER diagram can be generated in **MySQL Workbench**.  
- Indexing applied on primary lookups (timelines, posts, hashtags).  

---

## Deliverables
1. **SQL Script:** Contains all `CREATE DATABASE` and `CREATE TABLE` commands with PKs, FKs, and constraints.  
2. **ER Diagram:** Visual representation of tables and relationships.  
3. **README:** Documentation explaining schema design, entities, and relationships.  

---

## Learning Outcomes
- Learned **database setup and schema design** in MySQL.  
- Learned to define **primary/foreign keys**, **constraints**, and **relationships**.  
- Gained experience in **advanced social media database modeling**, including unique features.  
- Prepared a **scalable, efficient database schema** for high-read and high-write operations.  

---

## Next Steps / Optional Enhancements
- Implement **advanced tables**: `Post_Versions`, `Post_CoAuthor`, `Moderation`, `Content_Provenance`, `AR_Scenes`, `Local_Threads`, `Wallets`, `Transactions`.  
- Add **indexes and partitioning** for performance optimization.  
- Connect to a **frontend or API** to simulate feed generation and engagement tracking.  

---

## Usage
1. Clone the repository.  
2. Run the SQL script in **MySQL Workbench** or via command line:  
   ```bash
   mysql -u <username> -p < connects.sql
