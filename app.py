from flask import Flask, render_template, request, jsonify, session
import pymysql
import os

app = Flask(__name__)


app.secret_key = os.urandom(24)

# الاتصال بقاعدة البيانات
conn = pymysql.connect(
    host="localhost",
    user="root",
    password="Natigaa@2022",
    database="ecommerce_platform",
    charset='utf8mb4'
)
cursor = conn.cursor()

@app.route('/')
def index():
    search_term = request.args.get('search', '')  
    if search_term:
        
        cursor.execute(
            """
            SELECT p.product_id, p.name, p.description, p.price, p.stock_quantity, c.name AS category
            FROM Products p
            LEFT JOIN Categories c ON p.category_id = c.category_id
            WHERE p.name LIKE %s
            """,
            ('%'+ search_term + '%',)
        )

        products = cursor.fetchall()

        
        if not products:
            return render_template('index.html', products=products, cart_count=len(session.get('cart_items', [])), 
                                   message="No products found. Please try a different search term.")

    else:
       
        cursor.execute(
            """
            SELECT p.product_id, p.name, p.description, p.price, p.stock_quantity, c.name AS category
            FROM Products p
            LEFT JOIN Categories c ON p.category_id = c.category_id
            ORDER BY p.product_id DESC  -- ترتيب المنتجات الأحدث أولاً
            LIMIT 3  -- عرض 3 منتجات فقط
            """
        )
        products = cursor.fetchall()

   
    return render_template('index.html', products=products, cart_count=len(session.get('cart_items', [])), message=None)

@app.route('/add_to_cart', methods=['POST'])
def add_to_cart():
    product_id = request.form.get('product_id')
    product_name = request.form.get('product_name')

    
    cart_items = session.get('cart_items', [])
    cart_items.append({"product_id": product_id, "product_name": product_name})

     
    session['cart_items'] = cart_items


    return jsonify(cart_count=len(cart_items))

@app.before_request
def initialize_session():
   
    if 'cart_items' not in session:
        session['cart_items'] = []

if __name__ == '__main__':
    app.run(debug=True)
