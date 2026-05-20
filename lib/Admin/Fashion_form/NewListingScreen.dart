import 'package:flutter/material.dart';

class NewListingScreen extends StatefulWidget {
  const NewListingScreen({super.key});

  @override
  State<NewListingScreen> createState() => _NewListingScreenState();
}

class _NewListingScreenState extends State<NewListingScreen> {
  String selectedSize = "M";
  Color selectedColor = Colors.blue;
  bool localPickup = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F6F8),
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 420),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 30,
                  color: Colors.black.withOpacity(.15),
                )
              ],
            ),
            child: Stack(
              children: [
                Column(
                  children: [
                    _header(),
                    Expanded(child: _body()),
                  ],
                ),
                _footer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /* ================= HEADER ================= */

  Widget _header() {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text("Cancel",
              style: TextStyle(fontSize: 14, color: Colors.grey)),
          Text("New Listing",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          Text("Save Draft",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff135BEC))),
        ],
      ),
    );
  }

  /* ================= BODY ================= */

  Widget _body() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 120),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _photoUploader(),
          _divider(),
          _itemDetails(),
          _sizeSection(),
          _colorSection(),
          _divider(),
          _materialSection(),
          _divider(),
          _pricingSection(),
          _divider(),
          _shippingSection(),
        ],
      ),
    );
  }

  /* ================= PHOTO UPLOAD ================= */

  Widget _photoUploader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            height: 260,
            decoration: BoxDecoration(
              color: const Color(0xff135BEC).withOpacity(.05),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                  color: const Color(0xff135BEC).withOpacity(.3),
                  width: 2,
                  style: BorderStyle.solid),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.add_a_photo_outlined,
                      size: 32, color: Color(0xff135BEC)),
                ),
                SizedBox(height: 12),
                Text("Add up to 8 photos",
                    style:
                    TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                SizedBox(height: 4),
                Text("Tap to upload or drag here",
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /* ================= ITEM DETAILS ================= */

  Widget _itemDetails() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _sectionTitle("Item Details"),
        const SizedBox(height: 20),
        _label("Product Title"),
        _input("e.g. Vintage Denim Jacket"),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label("Category"),
                  _dropdown(["Women", "Men", "Kids", "Unisex"]),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label("Brand"),
                  _input("Zara, Nike...", icon: Icons.search),
                ],
              ),
            ),
          ],
        ),
      ]),
    );
  }

  /* ================= SIZE ================= */

  Widget _sizeSection() {
    final sizes = ["XS", "S", "M", "L", "XL"];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _label("Size & Fit"),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: sizes.map((s) {
            final active = s == selectedSize;
            return GestureDetector(
              onTap: () => setState(() => selectedSize = s),
              child: Container(
                width: 64,
                height: 44,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color:
                  active ? const Color(0xff135BEC) : Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                      color: active
                          ? const Color(0xff135BEC)
                          : Colors.grey.shade300),
                ),
                child: Text(
                  s,
                  style: TextStyle(
                      color: active ? Colors.white : Colors.grey[700],
                      fontWeight: FontWeight.w600),
                ),
              ),
            );
          }).toList(),
        ),
      ]),
    );
  }

  /* ================= COLOR ================= */

  Widget _colorSection() {
    final colors = [
      Colors.black,
      Colors.white,
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.yellow
    ];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _label("Color"),
        const SizedBox(height: 12),
        Wrap(
          spacing: 14,
          children: colors.map((c) {
            final selected = selectedColor == c;
            return GestureDetector(
              onTap: () => setState(() => selectedColor = c),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: c,
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: selected
                          ? const Color(0xff135BEC)
                          : Colors.grey.shade300,
                      width: selected ? 2 : 1),
                ),
                child: selected
                    ? const Icon(Icons.check, color: Colors.white, size: 18)
                    : null,
              ),
            );
          }).toList(),
        ),
      ]),
    );
  }

  /* ================= MATERIAL ================= */

  Widget _materialSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _label("Material & Care / Condition"),
        _textarea("Describe fabric, washing & condition"),
      ]),
    );
  }

  /* ================= PRICING ================= */

  Widget _pricingSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _label("Pricing"),
        TextField(
          keyboardType: TextInputType.number,
          decoration: _decoration("0.00").copyWith(prefixText: "\$ "),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xffF6F6F8),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("Estimated earnings",
                  style: TextStyle(color: Colors.grey)),
              Text("\$0.00",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(0xff135BEC))),
            ],
          ),
        ),
      ]),
    );
  }

  /* ================= SHIPPING ================= */

  Widget _shippingSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _sectionTitle("Shipping & Delivery"),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Local Pickup",
                    style: TextStyle(fontWeight: FontWeight.w500)),
                Text("Allow buyers to pick up",
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
            Switch(
              value: localPickup,
              activeColor: const Color(0xff135BEC),
              onChanged: (v) => setState(() => localPickup = v),
            )
          ],
        ),
        const SizedBox(height: 16),
        _label("Shipping Method"),
        _dropdown([
          "Standard Shipping (3-5 Days)",
          "Express Shipping (1-2 Days)",
          "Seller Arranged Shipping",
          "Digital Delivery"
        ]),
      ]),
    );
  }

  /* ================= FOOTER ================= */

  Widget _footer() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.shade200)),
        ),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff135BEC),
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
          child: const Text("Post Item",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }

  /* ================= HELPERS ================= */

  Widget _divider() => Container(height: 8, color: const Color(0xffF6F6F8));

  Widget _sectionTitle(String t) => Row(children: [
    Container(
        width: 4,
        height: 22,
        decoration: BoxDecoration(
            color: const Color(0xff135BEC),
            borderRadius: BorderRadius.circular(4))),
    const SizedBox(width: 10),
    Text(t, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600))
  ]);

  Widget _label(String t) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(t.toUpperCase(),
        style: const TextStyle(
            fontSize: 11,
            letterSpacing: 1,
            color: Colors.grey,
            fontWeight: FontWeight.w600)),
  );

  Widget _input(String h, {IconData? icon}) => TextField(
    decoration: _decoration(h).copyWith(
        suffixIcon:
        icon != null ? Icon(icon, size: 20, color: Colors.grey) : null),
  );

  Widget _textarea(String h) => TextField(
    maxLines: 4,
    decoration: _decoration(h),
  );

  Widget _dropdown(List<String> items) => DropdownButtonFormField<String>(
    items: items
        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
        .toList(),
    onChanged: (_) {},
    decoration: _decoration(""),
  );

  InputDecoration _decoration(String h) => InputDecoration(
    hintText: h,
    filled: true,
    fillColor: const Color(0xffF2F2F4),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none),
    contentPadding:
    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  );
}
