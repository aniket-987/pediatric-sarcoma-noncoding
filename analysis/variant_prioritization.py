import pandas as pd
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import train_test_split
from sklearn.metrics import classification_report, roc_auc_score

def load_and_prep_data(filepath):
    df = pd.read_csv(filepath)
    features = ['phyloP_score', 'enhancer_activity_score', 'distance_to_tss']
    X = df[features]
    y = df['is_pathogenic']
    return X, y

def train_prioritization_model(X, y):
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)
    
    model = RandomForestClassifier(n_estimators=100, max_depth=5, random_state=42)
    model.fit(X_train, y_train)
    
    predictions = model.predict(X_test)
    probabilities = model.predict_proba(X_test)[:, 1]
    
    print("\n--- Model Evaluation ---")
    print(classification_report(y_test, predictions))
    print(f"ROC-AUC Score: {roc_auc_score(y_test, probabilities):.3f}")
    
    importances = model.feature_importances_
    print("\n--- Feature Importance ---")
    for feature, imp in zip(X.columns, importances):
        print(f"{feature}: {imp:.3f}")
        
    return model

if __name__ == "__main__":
    try:
        X, y = load_and_prep_data("annotated_variants.csv")
        trained_model = train_prioritization_model(X, y)
    except FileNotFoundError:
        print("Error: 'annotated_variants.csv' not found.")